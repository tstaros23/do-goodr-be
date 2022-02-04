class EventSerializer

  def self.format_json(event)
    {
      type: 'event',
      data: format_event(event)
    }
  end

  def self.format_event(event)
    if event.is_a?(Array)
      collection = event.flatten
    else
      collection = [event]
    end
    # require "pry"; binding.pry
    collection.map do |obj|
      {
        organization_id: obj.organization_id,
        name: obj.name,
        category: obj.category,
        address: obj.address,
        description: obj.description,
        vols_required: obj.vols_required
      }
    end
  end

end
