require 'machine'
require 'robot'
require 'report'
require 'stringio'
require 'test/unit'

class ReportTest < Test::Unit::TestCase

  def test_report
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
    assert_equal expected, out.string
  end

  def test_robot
    sorter = Machine.new("Sorter", "left")
    sorter.put("chips")
    oven = Machine.new("Oven", "middle")
    robot = Robot.new

    assert_equal "chips", sorter.bin
    assert_nil oven.bin
    assert_nil robot.location
    assert_nil robot.bin

    robot.move_to(sorter)
    robot.pick
    robot.move_to(oven)
    robot.release

    assert_nil robot.bin
    assert_equal oven, robot.location
    assert_nil sorter.bin
    assert_equal "chips", oven.bin
  end
end
