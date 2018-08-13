class Oystercard
  DEFAULT_LIMIT = 9000
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Cannot top up over maximum limit (£90)" if check_within_limit(amount)
    @balance += amount
  end

  def check_within_limit(amount)
    @balance + amount > DEFAULT_LIMIT
  end

end
