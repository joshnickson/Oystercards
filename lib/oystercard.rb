class Oystercard
  DEFAULT_LIMIT = 9000
  MINIMUM_FARE = 100
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Cannot top up over maximum limit (£#{DEFAULT_LIMIT/100})" if check_within_limit(amount)
    @balance += amount
  end

  def deduct(fare) # consider adding error if takes below 0
    @balance -= fare
  end

  def touch_in
    fail "Insufficient funds on card (required £#{MINIMUM_FARE/100})" if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private
  def check_within_limit(amount)
    @balance + amount > DEFAULT_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

end
