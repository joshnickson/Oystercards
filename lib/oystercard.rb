class Oystercard
  DEFAULT_LIMIT = 9000

  attr_reader :balance, :journeys

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journeys = journey_log
  end

  def top_up(amount)
    raise "Cannot top up over maximum limit (£#{DEFAULT_LIMIT/100})" if check_within_limit(amount)
    @balance += amount
  end

  def touch_in(station, journey = Journey.new)
    fail "Insufficient funds on card (required £#{Journey::MINIMUM_FARE/100})" if insufficient_funds?
    deduct(@journeys.last.fare) if in_journey?
    journey.in_s = station
    @journeys << journey
  end

  def touch_out(station, journey = @journeys.last)
    if !in_journey?
      journey = Journey.new
      @journeys << journey
    end
    journey.out = station
    deduct(journey.fare)
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
    @balance < Journey::MINIMUM_FARE
  end

  def deduct(fare) # consider adding error if takes below 0
    @balance -= fare
  end

end
