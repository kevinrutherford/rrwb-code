class Report
  def Report.report(out, machines, robot)
    out.print "FACTORY REPORT\n"
    machines.each do |machine|
      out.print "Machine #{machine.name}"
      out.print " bin=#{machine.bin}" if machine.bin != nil
      out.print "\n"
    end
    out.print "\n"
    out.print "Robot"
    if robot.location != nil
      out.print " location=#{robot.location.name}"
    end
    out.print " bin=#{robot.bin}" if robot.bin != nil
    out.print "\n"
    out.print "========\n"
  end
end