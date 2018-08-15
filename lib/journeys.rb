class Journey
  MINIMUM_FARE = 100
  PENALTY = 600

  attr_accessor :in_s, :out

  def complete?
    !!out && !!in_s
  end

  def fare
    if complete?
      MINIMUM_FARE
    else
      PENALTY
    end
  end

end
