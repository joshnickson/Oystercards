class JourneyLog

  attr_reader :journeys

  def initialize(journey_klass = Journey)
    @journeys = []
    @journey_klass = journey_klass
  end

  def start(station)
    journey = @journey_klass.new
    journey.in_s = station
    @journeys << journey
  end

  def finish(station)
    journey = @journeys.last
    journey.out = station
  end

end
