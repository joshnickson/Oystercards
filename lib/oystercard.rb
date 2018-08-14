class Oystercard
  DEFAULT_LIMIT = 9000
  MINIMUM_FARE = 100
  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Cannot top up over maximum limit (£#{DEFAULT_LIMIT/100})" if check_within_limit(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds on card (required £#{MINIMUM_FARE/100})" if insufficient_funds?
    @journeys << station
    @entry_station = station
  end

  def touch_out(station)
    @journeys << station
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    !@entry_station.nil?
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
