class MapquestFacade

  def self.event_search(zip, distance)
    events = Event.future_events.map do |event|
      {distance: distance(zip, event.address), event: event}
    end
  end

  def self.distance(zip, event_address)
    distance = MapquestService.route(zip, event_address)[:route][:distance]
  end

end
