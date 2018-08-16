class Journey
  MINIMUM_FARE = 100
  PENALTY = 600

  attr_accessor :in_s, :out

  def fare
    complete? ? MINIMUM_FARE : PENALTY
  end

  def complete?
    !!out && !!in_s
  end

end
