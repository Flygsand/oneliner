require 'oneliner/errors'

module Oneliner

  class Command
    
    class << self
      def description(description = nil)
        @description = description || @description
      end
    end
    
    def description
      self.class.description
    end

    def initialize(app)
      @app = app
    end
    
    def ui
      raise Oneliner::Errors::CommandError, 'No UI available' unless @app.ui
      @app.ui
    end
  end
  
end
