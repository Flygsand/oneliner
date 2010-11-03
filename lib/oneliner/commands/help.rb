require 'oneliner/command'

module Oneliner::Commands

  class Help < Oneliner::Command

    description 'View the man page for a command'

    def run!(*args)
      command = args.first
      raise Oneliner::Errors::CommandError, 'no command given' if command.nil?
      raise Oneliner::Errors::CommandError, 'man is not installed on your system' unless man_available?

      man(command)
    end

    private
    def man_available?
      `which man 2> /dev/null`
      $? == 0
    end
    
    def man(command)
      Kernel.exec("man #{@app.name}-#{command}")
    end
  end
end
