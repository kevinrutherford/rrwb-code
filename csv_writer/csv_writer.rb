class CsvWriter

  def write(lines)
    lines.each { |line| write_line(line) }
  end

private

  def write_line(fields)
    if (fields.length == 0)
      puts
    else
      write_field(fields[0])
      1.upto(fields.length-1) do |i|
        print ","
        write_field(fields[i])
      end
      puts
    end
  end

  def write_field(field)
    case field
      when /,/ then write_quoted(field)
      when /"/ then write_quoted(field)
      else print(field)
    end
  end

  def write_quoted(field)
    print "\""
    print field.gsub(/\"/, "\"\"")
    print "\""
  end
end
