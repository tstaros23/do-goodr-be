class Organization < ApplicationRecord
  has_many :events

  validates_presence_of :name, :location, :phone, :email

end
