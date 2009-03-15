require 'value'

# Run with: spec value_spec.rb --format specdoc

describe Value, "for dimension-less numbers" do
  before do
    @v1 = Value.new 8, Dimension.new
    @v2 = Value.new 4, Dimension.new 
  end
    
  it "computes like normal arithmetic" do
    (@v1 + @v2).should == (Value.new 12, Dimension.new)
    (@v1 - @v2).should == (Value.new 4, Dimension.new)
    (@v1 * @v2).should == (Value.new 32, Dimension.new)
    (@v1 / @v2).should == (Value.new 2, Dimension.new)
  end
  
  it "just returns the number as its string form" do
    @v1.to_s.should == '8'
  end
end

describe Value, "for compatible dimensions" do
  before do
    @v1 = Value.new 8, Dimension.new({"m"=>2})
    @v2 = Value.new 4, Dimension.new({"m"=>2})
  end
  
  it "addition and subtraction have the same dimension" do
    (@v1 + @v2).should == (Value.new 12, Dimension.new({"m"=>2}))
    (@v1 - @v2).should == (Value.new 4, Dimension.new({"m"=>2}))
  end
  
  it "multiplication results in product of dimensions" do
    (@v1 * @v2).should == (Value.new 32, Dimension.new({"m"=>4}))
  end
  
  
  it "division results in division of dimensions" do
    (@v1 / @v2).should == (Value.new 2, Dimension.new)
  end
  
end

describe Value, "for incompatible dimensions" do
  before do
    @v1 = Value.new 8, Dimension.new({"m"=>2})
    @v2 = Value.new 4, Dimension.new({"s"=>-3})
  end
  
  it "error if addition and subtraction have differing dimensions" do
    lambda{(@v1 + @v2)}.should raise_error
    lambda{(@v1 - @v2)}.should raise_error
  end
  
  it "multiplication should multiply dimensions" do
    (@v1 * @v2).should == (Value.new 32, Dimension.new({"m"=>2, "s"=>-3}))
  end
  
  it "division should invert and multiply dimensions" do
    (@v1 / @v2).should == (Value.new 2, Dimension.new({"m"=>2, "s"=>3}))
  end
  
  it "should multiply number times dimension for string form" do
    @v1.to_s.should == '8*m^2'
  end
end

describe Value, "for unreduced dimensions" do
  before do
    @v1 = Value.new 18, Dimension.new({"t"=>1})
    @v2 = Value.new 3, Dimension.new({"t"=>-2})
  end

  it "should have computed empty dimension be equivalent to a new empty dimension" do
    (@v1 / @v1).should == (Value.new 1, Dimension.new)
  end
  
  it "should have computed complex dimension be equivalent to a reduced dimension" do
    ((@v1 * @v2) * @v2).should ==  (Value.new 162, Dimension.new({"t"=>-3}))
  end
end

describe Value, "to extend" do
  before do
    @v1 = Value.new(8, Dimension.new({"t"=>2}))
  end
    
  it "should grow with either number or dimension" do
    @v1.extend(4).should == (Value.new 84, Dimension.new({"t"=>2}))
    @v1.extend(Dimension.new({"m"=>-1})).should == (Value.new 8, Dimension.new({"t"=>2, "m"=>-1}))
  end
end
