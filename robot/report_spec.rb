require 'machine'
require 'robot'
require 'report'
require 'stringio'

describe Report do
  it 'should report the state of everything' do
    line = []
    line << Machine.new("mixer", "left")

    extruder = Machine.new("extruder", "center")
    extruder.put("paste")
    line << extruder

    oven = Machine.new("oven", "right")
    oven.put("chips")
    line << oven

    robot = Robot.new
    robot.move_to(extruder)
    robot.pick

    out = StringIO.new
    Report.report(out, line, robot)

    expected = <<END_OF_EXPECTED
FACTORY REPORT
Machine mixer
Machine extruder
Machine oven bin=chips

Robot location=extruder bin=paste
========
END_OF_EXPECTED
    out.string.should == expected
  end
end
