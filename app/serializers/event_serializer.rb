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

  # def self.format_get(event)
  #   {
  #     type: 'event',
  #     data:
  #         [
  #           {
  #           name: event.name,
  #           category: event.category,
  #           address: event.address,
  #           description: event.description,
  #           vols_required: event.vols_required
  #         }
  #       ]
  #       end
  #   }
  # end
end
