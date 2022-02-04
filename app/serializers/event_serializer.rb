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
            vols_required: event.vols_required
          }
        ]
    }
  end

  def self.format_get(event)
    {
      type: 'event',
      data:
          event.map do |obj|
          {
            organization_id: obj.organization_id,
            name: obj.name,
            category: obj.category,
            address: obj.address,
            description: obj.description,
            vols_required: obj.vols_required
          }
        
        end
    }
  end
end
