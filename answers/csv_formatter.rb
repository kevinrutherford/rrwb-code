class CsvFormatter

  def format(lines)
    lines.collect { |line| write_line(line) }.join("\n")
  end

private

  def write_line(fields)
    fields.collect { |field| write_field(field) }.join(",")
  end

  def write_field(field)
    case field
      when /,/ then quote_and_escape(field)
      when /"/ then quote_and_escape(field)
      else field
    end
  end

  def quote_and_escape(field)
    "\"#{field.gsub(/\"/, "\"\"")}\""
  end
end
