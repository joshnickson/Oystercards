class JourneyLog

  attr_reader :journeys

  def initialize(journey_klass = Journey)
    @journeys = []
    @journey_klass = journey_klass
  end


  def start(station)
    journey = @journey_klass.new
    @journeys << journey
    journey.in_s = station
  end


  def finish(station)
    if !in_journey?
      journey = @journey_klass.new
      @journeys << journey
    end
    @journeys.last.out = station
  end

  def in_journey?
    return false if @journeys.empty?
    !@journeys.last.out
  end

end
