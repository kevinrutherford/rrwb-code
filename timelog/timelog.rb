#! /usr/bin/ruby
#
# Usage:
#
# timelog [--user USERNAME] [[--date d] [--hours] hrs] project
#

require 'ostruct'
require 'optparse'
require 'optparse/date'

def parse_options(argv)
  options = OpenStruct.new
  OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options] project_name"

    opts.on("-d", "--date DATE", Date,
        "Specify the date on which hours were worked") do |d|
      options.date = d
    end
    opts.on("-h", "--hours NUM", Float,
        "The number of hours worked") do |hrs|
      options.hours = hrs
    end
    opts.on("-u", "--user USERNAME", String,
        "Log time for a different user") do |user|
      options.user = user
    end
    opts.on_tail("-?", "--help", "Show this message") do
      puts opts
      exit
    end
  end.parse!

  if argv.length < 1
    puts "Usage: #{$0} [options] project_name"
    exit
  end

  if argv.length == 2
    hours = argv.shift
    options.hours = hours.to_f
  end

  if options.hours && options.hours <= 0.0
    raise OptionParser::InvalidArgument, hours
  end

  options.project = argv[0]
  options
end

TIMELOG_FOLDER = ENV['TL_DIR'] || '/var/log/timelog'
TIMELOG_FILE_NAME = 'timelog.txt'
TIMELOG_FILE = TIMELOG_FOLDER + '/' + TIMELOG_FILE_NAME

def report(options)
  records = IO.readlines(TIMELOG_FILE)
  records = records.grep(/^#{options.project},/)
  records = records.grep(/,#{options.user},/) if options.user
  months = Hash.new(0.0)
  total = 0.0
  records.each do |record|
    project, user, date, hours = record.split(/,/)
    total += hours.to_f
    y, m, d = date.split(/-/)
    months["#{y}-#{m}"] += hours.to_f
  end
  lines = months.keys.sort.map { |month|
    "%-7s %8.1f" % [month, months[month]]
  }
  lines << "Total   %8.1f" % total
  lines.join("\n")
end

def log(options)
  options.user ||= ENV['USERNAME']
  options.date ||= Date.today.to_s
  File.open TIMELOG_FILE, 'a+' do |f|
    f.puts "#{options.project},#{options.user},#{options.date},#{options.hours}"
  end
end

if __FILE__ == $PROGRAM_NAME
  options = parse_options(ARGV)
  if options.hours.nil?
    puts report(options)
  else
    log(options)
  end
end
