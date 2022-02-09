class EventSerializer

  def self.format_single(event)

    {
      type: 'event',
      data:
          [
            {
            id: event.id,
            organization_id: event.organization_id,
            organization_name: event.organization.name,
            name: event.name,
            category: event.category,
            address: event.address,
            phone: event.phone,
            description: event.description,
            vols_required: event.vols_required,
            date: Time.at(event.start_time).strftime('%m/%d/%Y'),
            start_time: Time.at(event.start_time).strftime('%I:%M %p'),
            end_time: Time.at(event.end_time).strftime('%I:%M %p')
          }
        ]
    }
  end

  def self.format_multiple(events)
    {
      type: 'event',
      data:
          events.map do |obj|
          {
            id: obj.id,
            organization_id: obj.organization_id,
            organization_name: obj.organization.name,
            name: obj.name,
            category: obj.category,
            address: obj.address,
            phone: obj.phone,
            description: obj.description,
            vols_required: obj.vols_required,
            date: Time.at(obj.start_time).strftime('%m/%d/%Y'),
            start_time: Time.at(obj.start_time).strftime('%I:%M %p'),
            end_time: Time.at(obj.end_time).strftime('%I:%M %p')
          }
        end
    }
  end

  def self.format_search(events)
    {
      type: 'event',
      data:
          events.map do |obj|
          {
            id: obj[:event].id,
            distance: obj[:distance],
            organization_id: obj[:event].organization_id,
            organization_name: obj[:event].organization.name,
            name: obj[:event].name,
            category: obj[:event].category,
            address: obj[:event].address,
            phone: obj[:event].phone,
            description: obj[:event].description,
            vols_required: obj[:event].vols_required,
            date: Time.at(obj[:event].start_time).strftime('%m/%d/%Y'),
            start_time: Time.at(obj[:event].start_time).strftime('%I:%M %p'),
            end_time: Time.at(obj[:event].end_time).strftime('%I:%M %p')
          }
        end
    }
  end
end
