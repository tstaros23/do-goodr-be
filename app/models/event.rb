class Event < ApplicationRecord
  belongs_to :organization

  before_save :normalize_phone

  validates_presence_of :name, :category, :address, :description, :phone, :vols_required, :organization_id, :start_time, :end_time
  validates :phone, phone: true

  enum category: {"Nursing Home" => 0, "Grounds Cleanup" => 1, "Animal Care" => 2, "Campaigning" => 3, "Food Service" => 4, "Youth Mentorship" => 5, "Community Development" => 6, "Healthcare" => 7, "Other" => 8}

  def self.future_events
    where "start_time > ?", DateTime.now
  end

  def self.distance_filter(zip, distance)
    events = MapquestFacade.event_search(zip, distance)
    e = events.filter_map do |event|
      if event[:distance].nil?
        nil
      elsif event[:distance] < distance.to_f
        event
      end
    end
    e.sort_by do |k|
      k[:distance]
    end
  end

  def self.organization_filter(org_id)
    where "organization_id = ?", org_id
  end

  private

  def normalize_phone
    phone = Phonelib.parse(phone).full_e164
  end
end
