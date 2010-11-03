require 'oneliner/errors'

class String
  def snakecase
    self.gsub(/(.)([A-Z])/,'\1_\2').downcase
  end
end

module Oneliner
  class App

    class << self

      def name(name = nil)
        @name = name || @name || File.basename($0)
      end

      def description(description = nil)
        @description = description || @description
      end
      
      def commands(mod = nil)
        @commands ||= {}
        
        mod ? recursively_load_commands_from(mod) : @commands
      end

      def ui(ui = nil)
        @ui = ui || @ui
      end
      
      def run!(argv = nil)
        command, *args = argv || ARGV

        if command
          begin
            raise Oneliner::Errors::CommandError, "Undefined command '#{command}'" unless commands.include?(command)
            commands[command].new(self).run!(*args)
          rescue Exception => e
            STDERR.puts "error: #{e.message}"
          end
        
        else
          list_commands
        end
      end
      
      private
      def recursively_load_commands_from(mod, ns = nil)
        constants = mod.constants.map { |n| [qualify(n.snakecase, ns), mod.const_get(n)] }
        commands, others = constants.partition { |c| c.last < Oneliner::Command }
        others.select { |c| c.last.class == Module }.each { |m| recursively_load_commands_from(m.last, m.first) }
        @commands.merge!(Hash[commands])
      end

      def list_commands
        commands.each_pair do |name, command|
          puts "#{name}\t\t\t\t#{command.description}"
        end
      end

      def qualify(name, ns)
        ns ? "#{ns}.#{name}" : name
      end
    end
    
  end
end
