class Organization < ApplicationRecord
  has_many :events, dependent: :destroy

  validates_presence_of :name, :location, :phone, :email

end
