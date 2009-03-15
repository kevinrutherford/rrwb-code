require 'value'
require 'calculator'
require 'calc_controller'

# Run with: spec calc_controller_spec.rb --format specdoc

describe Calc_Controller, "for an empty calculator" do
  before do
    @calc = Calculator.new(Value.new(0, Dimension.new))
    @controller = Calc_Controller.new @calc
  end
    
  it "extends digits" do
    @controller.digit  3
    @controller.digit 4
    @calc.to_s.should == '34'
  end
  
  it "clears number and extends units when the top is calculated" do
    @calc.push(Value.new(1, Dimension.new))
    @calc.push(Value.new(2, Dimension.new))
    @calc.plus
    @controller.unit(Dimension.new({"m"=>2}))
    @calc.to_s.should == '0*m^2'
  end

  it "extends units without clearing when the top was freshly pushed" do
    @calc.push(Value.new(7, Dimension.new))
    @controller.unit(Dimension.new({"s"=>-1}))
    @calc.to_s.should == "7*1/s"
  end
  
  it "pushes an empty value" do
    @calc.push(Value.new(8, Dimension.new))
    @controller.push
    @calc.to_s.should == '0'
  end
  
  it "can pop what was pushed" do
    @calc.push(Value.new(9, Dimension.new))
    @controller.pop
    @controller.to_s.should == '0'
  end
  
  it "can rotate (cab) what's on the stack" do
      @calc.push 'c'
      @calc.push 'b'
      @calc.push 'a'
      @controller.to_s.should == 'a'   # check setup
      
      @controller.cab
      @controller.to_s.should == 'c'
      @controller.pop
      @controller.to_s.should == 'a'
      @controller.pop
      @controller.to_s.should == 'b'
  end

  it "can swap the top two stack elements" do
    @calc.push 'b'
    @calc.push 'a'
    @controller.to_s.should == 'a'   # check setup
    @controller.swap
    @controller.to_s.should == 'b'
  end
  
  it "can apply operations" do
    @calc.push(Value.new(10, Dimension.new))
    @calc.push(Value.new(11, Dimension.new))
    @controller.plus
    @calc.push(Value.new(9, Dimension.new))
    @controller.subtract
    @calc.push(Value.new(3, Dimension.new))
    @controller.times
    @calc.push(Value.new(4, Dimension.new))
    @controller.divide
    @controller.to_s.should == '9'    
  end
  
end
