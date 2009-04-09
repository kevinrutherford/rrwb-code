require 'machine'
require 'robot'

describe Robot, 'when new' do
  before :each do
    @robot = Robot.new
  end

  it 'has no location yet' do
    @robot.location.should be_nil
  end

  it 'does not point at a bin yet' do
    @robot.bin.should be_nil
  end
end

describe Robot, "in a world with machines" do
  before :each do
    @robot = Robot.new
    @sorter = Machine.new("Sorter", "left")
    @sorter.put("chips")
    @oven = Machine.new("Oven", "middle")
  end

  describe 'moving among machines' do
    it 'reports correct location' do
      @robot.move_to(@oven)
      @robot.location.should == @oven
    end
  end

  describe "moving and picking" do
    it 'should take the bin away from the machine' do
      lambda {
        @robot.move_to(@sorter)
        @robot.pick
      }.should change { @sorter.bin }.from("chips").to(nil)
    end
  end

  describe "picking and releasing" do
    def move_and_pick_and_move_and_release
      @robot.move_to(@sorter)
      @robot.pick
      @robot.move_to(@oven)
      @robot.release
    end

    it 'should take the bin away from the sorter' do
      lambda {
        move_and_pick_and_move_and_release
      }.should change { @sorter.bin }.from("chips").to(nil)
    end

    it 'should deposit the bin at the oven' do
      lambda {
        move_and_pick_and_move_and_release
      }.should change { @oven.bin }.from(nil).to("chips")
    end
  end
end
