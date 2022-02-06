require 'date'
require 'time'

class EventSerializer

  def self.format_new(event)
    {
      type: 'event',
      data:
          [
            {
            name: event.name,
            category: event.category,
            address: event.address,
            description: event.description,
            vols_required: event.vols_required,
            start_time: event.start_time,
            end_time: event.end_time
          }
        ]
    }
  end

  def self.format_get(events)
    {
      type: 'event',
      data:
          events.map do |obj|
          {
            organization_id: obj.organization_id,
            name: obj.name,
            category: obj.category,
            address: obj.address,
            description: obj.description,
            vols_required: obj.vols_required,
            start_time: obj.start_time,
            end_time: obj.end_time
          }
        end
    }
    require "pry"; binding.pry
  end

  def self.format_search(events)
    {
      type: 'event',
      data:
          events.map do |obj|
          {
            distance: obj[:distance],
            organization_id: obj[:event].organization_id,
            name: obj[:event].name,
            category: obj[:event].category,
            address: obj[:event].address,
            description: obj[:event].description,
            vols_required: obj[:event].vols_required,
            start_time: obj[:event].start_time,
            end_time: obj[:event].end_time
          }
        end
    }
  end
end
