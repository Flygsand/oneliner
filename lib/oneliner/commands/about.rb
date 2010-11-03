require 'oneliner/command'

module Oneliner
  module Commands
    class About < Oneliner::Command

      description 'Prints information about this app'
      
      def run!(*args)
        puts [@app.name, @app.description].reject { |l| l.nil? }.join("\n")
      end
      
    end
  end
end
