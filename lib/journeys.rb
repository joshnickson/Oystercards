class Journey
  attr_accessor :in_s, :out

  def complete?
    !!out && !!in_s
  end

  def fare
    if complete?
      Oystercard::MINIMUM_FARE
    else
      Oystercard::PENALTY
    end
  end

end
