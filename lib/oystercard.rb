class Oystercard
  DEFAULT_LIMIT = 9000
  MINIMUM_FARE = 100
  PENALTY = 600
  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Cannot top up over maximum limit (£#{DEFAULT_LIMIT/100})" if check_within_limit(amount)
    @balance += amount
  end

  def touch_in(station, journey = Journey.new)
    fail "Insufficient funds on card (required £#{MINIMUM_FARE/100})" if insufficient_funds?

    if in_journey?
      deduct(PENALTY)
    end

    journey.in = station
    @journeys << journey
  end

  def touch_out(station, journey = @journeys.last)

    if !in_journey?
      journey = Journey.new
      journey.out = station
      @journeys << journey
      deduct(PENALTY)
    else
      journey.out = station
      deduct(MINIMUM_FARE)
    end
  end

  def in_journey?
    return false if @journeys.empty?
    !@journeys.last.out
  end

  private

  def check_within_limit(amount)
    @balance + amount > DEFAULT_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct(fare) # consider adding error if takes below 0
    @balance -= fare
  end

end
