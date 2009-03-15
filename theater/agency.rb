class Agency
  def self.book(num_reqd, theater)
    free_seats = []
    theater.seats.each_with_index do |item, index|
      free_seats << index if item == '-'
    end
    return nil if free_seats.empty?
    free_seats[0..num_reqd]
  end  
end
