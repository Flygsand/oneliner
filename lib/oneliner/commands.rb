module Oneliner
  module Commands; end
end

Dir["#{File.dirname(__FILE__)}/commands/**/*.rb"].each { |f| require f }
