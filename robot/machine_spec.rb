require 'machine'

describe Machine do
  before :each do
    @machine = Machine.new("Oven", "middle")
  end

  it 'should initially have no bin' do
    @machine.bin.should be_nil
  end

  it 'should accept things into its bin' do
    @machine.put("chips")
    @machine.bin.should == "chips"
  end
end
