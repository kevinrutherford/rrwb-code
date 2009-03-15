require 'rake/testtask'
require 'reek/rake_task'
require 'spec/rake/spectask'

DIRS = %w{answers array_queue checkpoint csv_writer matcher person robot simple_queue template theater tic_tac_toe timelog timer}

desc 'run the ucalc specs'
task :ucalc do
  Dir.chdir('ucalc') { sh 'spec *_spec.rb' }
end

Reek::RakeTask.new do |t|
  t.source_files = '**/*.rb'
end

Rake::TestTask.new do |t|
  t.libs = DIRS
  t.test_files = '**/*_test.rb'
end

desc 'runs all tests and specs'
task :default => [:test, :ucalc]
