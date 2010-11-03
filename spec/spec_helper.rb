require 'oneliner/command'
require 'oneliner/app'

module SpecHelper 
  module Commands

    class FirstCommand < Oneliner::Command

      description 'This is a description'

      def run!(*args)
        "first command ran with args #{args.join(', ')}"
      end
      
    end

    module MyNamespace
      class SecondCommand < Oneliner::Command; end
    end
  end

  module MoreCommands
    class ThirdCommand < Oneliner::Command; end
  end

  class App < Oneliner::App; end

  module UI; end
end
