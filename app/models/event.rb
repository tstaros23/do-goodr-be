class Event < ApplicationRecord
  belongs_to :organization

  validates_presence_of :name, :category, :address, :description, :vols_required

end
