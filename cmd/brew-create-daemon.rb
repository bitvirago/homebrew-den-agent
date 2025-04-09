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
        create_symlink
        create_log_directory

        # Build command arguments dynamically
        command_args = "/opt/bitrise/bin/bitrise-den-agent connect --intro-secret #{bitrise_agent_intro_secret} --server https://exec.bitrise.io"
        command_args += " --fetch-latest-cli" if args.fetch_latest_cli

        # Create plist content
        plist_content = create_plist_content(command_args, bitrise_agent_user_name, bitrise_agent_group_name)

        # Write plist to file
        plist_template_file = "/opt/homebrew/io.bitrise.self-hosted-agent.plist"
        FileUtils.mkdir_p(File.dirname(plist_template_file))
        File.write(plist_template_file, plist_content)

        # Output instructions
        output_instructions(plist_template_file, bitrise_agent_user_name)
      end

      private

      # Create symlink for the binary
      def create_symlink
        bin_path = "/opt/bitrise/bin"
        FileUtils.mkdir_p(bin_path) unless Dir.exist?(bin_path)

        symlink_target = "/opt/homebrew/bin/bitrise-den-agent"
        symlink_location = "#{bin_path}/bitrise-den-agent"

        if File.exist?(symlink_location)
          puts "Symlink already exists: #{symlink_location}"
        else
          File.symlink(symlink_target, symlink_location)
          puts "Symlink created: #{symlink_location} -> #{symlink_target}"
        end
      end

      # Create the log directory
      def create_log_directory
        log_path = "/opt/bitrise/var/log"
        FileUtils.mkdir_p(log_path) unless Dir.exist?(log_path)
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