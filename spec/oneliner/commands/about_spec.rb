require 'oneliner/commands/about'

describe Oneliner::Commands::About do

  before do
    @app = mock('app')
    @app.stub(:name).and_return('myapp')
    @app.stub(:description).and_return('my description of this app')
    @about = Oneliner::Commands::About.new(@app)
  end
  
  it 'has a meaningful description' do
    @about.description.should == 'Prints information about this app'
  end
  
  it 'prints some useful information' do
    @about.should_receive(:puts).with("myapp\nmy description of this app")
    @about.run!
  end
  
end
