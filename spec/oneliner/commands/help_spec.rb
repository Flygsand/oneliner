require 'oneliner/commands/help'
require 'oneliner/errors'

describe Oneliner::Commands::Help do

  before do
    @app = mock('app')
    @app.stub(:name).and_return('myapp')
    @help = Oneliner::Commands::Help.new(@app)
  end

  it 'has a meaningful description' do
    @help.description.should == 'View the man page for a command'
  end

  it 'runs man for a given command' do
    Kernel.should_receive(:exec).with('man myapp-mycommand')
    @help.run!('mycommand')
  end

  it 'raises a CommandError if no command is given' do
    lambda { @help.run! }.should raise_error(Oneliner::Errors::CommandError)
  end

end
