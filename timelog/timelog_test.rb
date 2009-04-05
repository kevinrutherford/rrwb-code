require 'test/unit'
load 'timelog.rb'

class TimelogTest < Test::Unit::TestCase
  def setup
    @varlog_size = File.size(TIMELOG_FILE) if File.exist?(TIMELOG_FILE)
    File.delete(TIMELOG_FILE_NAME) if File.exist?(TIMELOG_FILE_NAME)
    ENV['TL_DIR'] = '.'
    assert_equal('', `ruby timelog/timelog.rb -u fred -h 6 proj1`)
    assert_equal('', `ruby timelog/timelog.rb -u jim -h 7 proj1`)
    assert_equal('', `ruby timelog/timelog.rb -u alice -h 4.5 proj1`)
  end
  
  def teardown
    if File.exist?(TIMELOG_FILE)
      assert_equal(@varlog_size, File.size(TIMELOG_FILE),
        "log file #{TIMELOG_FILE} should be unchanged")
    end
    File.delete(TIMELOG_FILE_NAME) if File.exist?(TIMELOG_FILE_NAME)
  end

  def test_project_total
    rpt = `ruby timelog/timelog.rb proj1`.split("\n")[-1]
    assert_equal(17.5, rpt.split[1].to_f)
  end

  def test_project_total_for_missing_project
    rpt = `ruby timelog/timelog.rb proj2`.split("\n")[-1]
    assert_equal(0, rpt.split[1].to_f)
  end

  def test_user_total
    rpt = `ruby timelog/timelog.rb --user fred proj1`.split("\n")[-1]
    assert_equal(6, rpt.split[1].to_f)
  end

  def test_user_total_for_missing_user
    rpt = `ruby timelog/timelog.rb --user harry proj1`.split("\n")[-1]
    assert_equal(0, rpt.split[1].to_f)
  end

  def test_user_total_for_missing_project
    rpt = `ruby timelog/timelog.rb --user fred proj2`.split("\n")[-1]
    assert_equal(0, rpt.split[1].to_f)
  end
end
