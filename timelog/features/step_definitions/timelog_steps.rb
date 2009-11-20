When /I create a new timelog database/ do
  `rm -f timelog.txt`
end

When /^I run timelog (.*)$/ do |args|
  timelog(args)
end

Then /^stdout equals "([^\"]*)"$/ do |report|
  @last_stdout.should == report
end

Then /a total of ([\d\.]+) hours are reported/ do |expected|
  total_line = @last_stdout.split("\n")[-1]
  hrs = total_line.split[1].to_f
  hrs.should == expected.to_f
end