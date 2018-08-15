class Journey
  attr_accessor :in, :out

  def complete?
    !!out
  end

  def fare
    Oystercard::MINIMUM_FARE
  end

end
