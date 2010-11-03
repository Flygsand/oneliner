require 'oneliner/command'
require 'oneliner/errors'
require 'spec_helper'

describe Oneliner::Command do

  before do
    @app = mock('app')
    @command = SpecHelper::Commands::FirstCommand.new(@app)
  end

  describe '#description' do
    it 'returns the description' do
      @command.description.should == 'This is a description'
    end
  end

  describe '#ui' do

    it 'returns the associated UI' do
      @app.stub(:ui).and_return('ui')
      @command.ui == 'ui'
    end

    it 'raises a CommandError if no UI is available' do
      @app.stub(:ui)
      @command = SpecHelper::Commands::FirstCommand.new(@app)

      lambda { @command.ui }.should raise_error(Oneliner::Errors::CommandError)
    end
    
  end
  
end

