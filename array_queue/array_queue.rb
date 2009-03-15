class ArrayQueue < Array

  def add_rear(s)
    self << s
  end

  def remove_front
    self.delete_at(0)
  end
end
