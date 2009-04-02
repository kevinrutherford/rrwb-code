module SVG
  def self.rect(centre_x, centre_y, width, height, fill,
      stroke, stroke_width)
    %Q{<rect x="#{centre_x}" y="#{centre_y}"
     width="#{width}" height="#{height}"
     fill="#{fill}" stroke="#{stroke}"
     stroke-width="#{stroke_width}" />}
  end

  def self.text(x, y, msg, font_family, font_size, fill)
    %Q{<text x="#{x}" y="#{y}"
     font-family="#{font_family}" font-size="#{font_size}"
     fill="#{fill}" >#{msg}</text>}
  end

  def self.line(x1, y1, x2, y2, stroke, stroke_width)
    %Q{<line x1="#{x1}" y1="#{y1}" x2="#{x2}" y2="#{y2}"
     stroke="#{stroke}" stroke-width="#{stroke_width}" />}
  end

  def self.polyline(points, fill, stroke, stroke_width)
    %Q{<polyline fill="#{fill}" stroke="#{stroke}"
     stroke-width="#{stroke_width}"
     points = "#{points.join(' ')}" />}
  end
end