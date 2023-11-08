# frozen_string_literal: true

module Homebrew
  module_function

  def create_daemon_args
    Homebrew::CLI::Parser.new do
      description <<~EOS
        This tool generates a .plist file for the DEN agent, which is essential for the Bitrise DEN agent to function as a daemon.
      EOS
      flag   "--bitrise-agent-intro-secret=",
             description: "Bitrise DEN agent intro token."
    end
  end

  def create_daemon
    args = create_daemon_args.parse

    bitrise_agent_user_name = ENV["USER"]
    bitrise_agent_group_name = Etc.getgrgid(Process.gid).name
    bitrise_agent_intro_secret = args.bitrise-agent-intro-secret

    plist_content = <<~EOS
                      <?xml version="1.0" encoding="UTF-8"?>
                      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
                      <plist version="1.0">
                        <dict>
                          <key>Label</key>
                          <string>io.bitrise.self-hosted-agent</string>
                          <key>ProgramArguments</key>
                          <array>
                            <string>/bin/bash</string>
                            <string>-lc</string>
                            <string>/opt/homebrew/bin/bitrise-den-agent connect --intro-secret #{bitrise_agent_intro_secret} --server https://exec.bitrise.io</string>
                          </array>

                          <key>KeepAlive</key>
                          <true/>

                          <key>RunAtLoad</key>
                          <true/>

                          <key>SessionCreate</key>
                          <true/>

                          <key>UserName</key>
                          <string>#{bitrise_agent_user_name}</string>
                          <key>GroupName</key>
                          <string>#{bitrise_agent_group_name}</string>

                          <key>StandardOutPath</key>
                          <string>/Users/#{bitrise_agent_user_name}/bitrise-den-agent.log</string>
                          <key>StandardErrorPath</key>
                          <string>/Users/#{bitrise_agent_user_name}/bitrise-den-agent.log</string>
                        </dict>
                      </plist>
                  EOS
    plist_path = "/Users/"+bitrise_agent_user_name+"/Library/LaunchDaemons/io.bitrise.self-hosted-agent.plist"
    FileUtils.mkdir_p(File.dirname(plist_path))
    File.write(plist_path, plist_content)
  end
end
