require 'oneliner/app'
require 'spec_helper'

describe Oneliner::App do

  before do
    @app = SpecHelper::App
  end
  
  describe '#commands' do
    before do
      @app.commands SpecHelper::Commands
    end
    
    it 'loads commands from the given module' do
      @app.commands.size.should == 2
      @app.commands['first_command'].should == SpecHelper::Commands::FirstCommand
      @app.commands['my_namespace.second_command'].should == SpecHelper::Commands::MyNamespace::SecondCommand
    end

    it 'can be called consecutively to load more commands' do
      @app.commands SpecHelper::MoreCommands
      @app.commands.size.should == 3
      @app.commands['first_command'].should == SpecHelper::Commands::FirstCommand
      @app.commands['my_namespace.second_command'].should == SpecHelper::Commands::MyNamespace::SecondCommand
      @app.commands['third_command'].should == SpecHelper::MoreCommands::ThirdCommand
    end
  end

  describe '#ui' do
    it 'sets the ui' do
      @app.ui SpecHelper::UI
      @app.ui.should == SpecHelper::UI
    end
  end

  describe '#run' do

    before do
      @app.commands SpecHelper::Commands
    end

    it 'runs a command with arguments from ARGV' do
      ARGV = ['first_command', 'one', 'two']
      @app.run!.should == 'first command ran with args one, two'
    end

    it 'prints a list of call commands if no arguments are given' do
      @app.should_receive(:list_commands)
      @app.run!([])
    end

    it 'rescues exceptions raised by commands' do
      lambda { @app.run!(['unknown_command']) }.should_not raise_error
    end
  end
  
end
