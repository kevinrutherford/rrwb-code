require 'rubygems'
require 'tempfile'
require 'spec/expectations'
require 'fileutils'

class TimelogWorld
  def run(cmd)
    stderr_file = Tempfile.new('timelog-world')
    stderr_file.close
    @last_stdout = `#{cmd} 2> #{stderr_file.path}`
    @last_exit_status = $?.exitstatus
    @last_stderr = IO.read(stderr_file.path)
  end

  def timelog(args)
    ENV['TL_DIR'] = '.'
    run("ruby timelog.rb #{args}")
  end
end

World do
  TimelogWorld.new
end
