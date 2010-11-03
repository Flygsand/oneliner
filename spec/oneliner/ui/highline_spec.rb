require 'oneliner/ui/highline'

describe Oneliner::UI::Highline do

  it 'requires HighLine into its namespace' do
    Oneliner::UI::Highline.should respond_to(:ask)
  end
  
end
