# typed: strict
# frozen_string_literal: true

require "etc"
require "fileutils"
require "abstract_command"

module Homebrew
  module Cmd
    class CreateDaemon < AbstractCommand
      cmd_args do
        description <<~EOS
          This tool generates a .plist file for the DEN agent,
          which is essential for the Bitrise DEN agent to function as a daemon.
        EOS
        flag "--bitrise-agent-intro-secret=", description: "Bitrise DEN agent intro token."
        flag "--fetch-latest-cli", description: "If provided, adds '--fetch-latest-cli' to the bitrise-den-agent command."
      end

      def run
        # Parse arguments
        bitrise_agent_intro_secret = args.bitrise_agent_intro_secret

        # Get user info
        bitrise_agent_user_name = ENV["USER"]
        bitrise_agent_group_name = Etc.getgrgid(Process.gid).name

        # Create necessary directories
        create_required_directories

        # Copy the binary
        unless copy_binary
          return # Abort if copying the binary failed
        end

        # Build command arguments dynamically
        command_args = "/opt/bitrise/bin/bitrise-den-agent connect --intro-secret #{bitrise_agent_intro_secret} --server https://exec.bitrise.io"
        command_args += " --fetch-latest-cli" if args.fetch_latest_cli

        # Create plist content
        plist_content = create_plist_content(command_args, bitrise_agent_user_name, bitrise_agent_group_name)

        # Write plist to file
        plist_template_file = "/opt/homebrew/io.bitrise.self-hosted-agent.plist"
        FileUtils.mkdir_p(File.dirname(plist_template_file)) # Ensure the directory for the plist exists
        File.write(plist_template_file, plist_content)

        # Output instructions only if there were no errors
        output_instructions(plist_template_file, bitrise_agent_user_name)
      end

      private

      # Create necessary directories
      def create_required_directories
        directories = [
          "/opt/bitrise/var/log",
          "/opt/bitrise/releases",
          "/opt/bitrise/bin"
        ]

        directories.each do |dir|
          begin
            FileUtils.mkdir_p(dir)
          rescue Errno::EACCES => e
            puts "#{Tty.red}Permission denied, cannot create directory '#{dir}': #{e.message}#{Tty.reset}"
            puts "#{Tty.blue}Hint: Please manually create the directory and set the appropriate permissions.#{Tty.reset}"
            puts "#{Tty.green}Example command: #{Tty.bold}sudo mkdir -p #{dir}#{Tty.reset}"
          end
        end
      end

      # Copy the binary
      def copy_binary
        bin_path = "/opt/bitrise/bin"
        binary_source = "/opt/homebrew/bin/bitrise-den-agent"
        binary_destination = "#{bin_path}/bitrise-den-agent"

        # Check if the source file (the actual binary) exists
        unless File.exist?(binary_source)
          puts "#{Tty.red}The source file '#{binary_source}' does not exist.#{Tty.reset}"
          puts "#{Tty.blue}Hint: Please ensure that the Bitrise DEN agent is installed by running the command:#{Tty.reset}"
          puts "  brew install bitrise-den-agent"
          return false
        end

        begin
          # Copy the binary, overwriting if it exists
          FileUtils.cp(binary_source, binary_destination)
          # Set read and write permissions for the owner and group
          File.chmod(0755, binary_destination)  # rwxr-xr-x
          puts "Binary copied (overwritten): #{binary_destination}"
          return true
        rescue Errno::EACCES => e
          puts "#{Tty.red}Permission denied, cannot copy binary: #{e.message}#{Tty.reset}"
          puts "#{Tty.blue}Hint: You can copy the binary manually using the following command:#{Tty.reset}"
          puts "#{Tty.green}  #{Tty.bold}sudo cp #{binary_source} #{binary_destination}#{Tty.reset}"
          puts "#{Tty.red}Additionally, make sure the target directory exists and has the correct permissions.#{Tty.reset}"
          return false
        rescue Errno::ENOENT => e
          puts "#{Tty.red}The source file '#{binary_source}' does not exist.#{Tty.reset}"
          puts "#{Tty.blue}Please ensure that the Bitrise DEN agent is installed by running the command:#{Tty.reset}"
          puts "  brew install bitrise-den-agent"
          return false
        end
      end

      # Create plist content
      def create_plist_content(command_args, user_name, group_name)
        log_path = "/opt/bitrise/var/log"
        <<~EOS
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
            <dict>
              <key>Label</key>
              <string>io.bitrise.self-hosted-agent</string>
              <key>EnvironmentVariables</key>
              <dict>
                <key>PATH</key>
                <string>/usr/local/bin:/usr/bin/:/bin/:/opt/homebrew/bin:/opt/bitrise/bin</string>
              </dict>
              <key>ProgramArguments</key>
              <array>
                <string>/bin/bash</string>
                <string>-lc</string>
                <string>#{command_args}</string>
              </array>
              <key>KeepAlive</key>
              <true/>
              <key>RunAtLoad</key>
              <true/>
              <key>SessionCreate</key>
              <true/>
              <key>UserName</key>
              <string>#{user_name}</string>
              <key>GroupName</key>
              <string>#{group_name}</string>
              <key>StandardOutPath</key>
              <string>#{log_path}/agent.log</string>
              <key>StandardErrorPath</key>
              <string>#{log_path}/agent.log</string>
            </dict>
          </plist>
        EOS
      end

      # Output instructions for the user
      def output_instructions(plist_template_file, user_name)
        plist_target_path = "/Users/#{user_name}/Library/LaunchDaemons"
        puts <<~EOS
          Plist template file is located in the following directory:
            #{Tty.bold}#{plist_template_file}#{Tty.reset}
          For the daemon setup please run the following commands:
            #{Tty.bold}sudo mkdir -p #{plist_target_path}
            sudo chown root:wheel #{plist_target_path}
            sudo cp #{plist_template_file} #{plist_target_path}
            sudo chown root:wheel #{plist_target_path}/io.bitrise.self-hosted-agent.plist
            sudo launchctl load -w #{plist_target_path}/io.bitrise.self-hosted-agent.plist#{Tty.reset}
        EOS
      end
    end
  end
end