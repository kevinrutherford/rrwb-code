require 'value'
require 'calculator'

# Run with: spec calculator_spec.rb --format specdoc

describe Calculator, "for an empty calculator" do
  before do
    @calc = Calculator.new(Value.new(0, Dimension.new))
  end
    
  it "starts out considered to be calculated" do
    @calc.is_calculated.should == true
  end
  
  it "has the default value all the way down" do
    (@calc.top).should == Value.new(0, Dimension.new)
    @calc.pop
    (@calc.top).should == Value.new(0, Dimension.new)
  end

  it "has values you push" do
    @calc.push 20
    (@calc.top).should == 20
    @calc.is_calculated.should == false
  end
  
  it "can pop what was pushed" do
    @calc.push 17
    @calc.push 19
    @calc.push 20
    @calc.pop
    @calc.pop
    (@calc.top).should == 17
  end
  
  it "treats a pushed-and-popped item as newly calculated" do
      @calc.push 17
      @calc.push 18
      @calc.pop
      @calc.is_calculated.should == true
  end
  
end

describe Calculator, "for a calculator with values" do
  before do
    @calc = Calculator.new(0)
    @calc.push 2
    @calc.push 15
    @calc.push 5
  end
    
  it "can add" do
    @calc.plus
    @calc.plus
    @calc.top.should == 22
    @calc.is_calculated.should == true
  end
  
  it "can subtract" do
    @calc.minus
    @calc.top.should == 10
    @calc.is_calculated.should == true
  end
  
  it "can multiply" do
    @calc.times
    @calc.top.should == 75
    @calc.is_calculated.should == true
  end
  
  it "can divide" do
    @calc.divide
    @calc.top.should == 3
    @calc.is_calculated.should == true
  end
end
