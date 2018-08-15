class Journey
  attr_accessor :in, :out

  def complete?
    !!out
  end

end
