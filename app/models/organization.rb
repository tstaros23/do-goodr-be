class Organization < ApplicationRecord
  has_many :events, dependent: :destroy

  validates_presence_of :name, :location, :phone
  validates :email, presence: true, 'valid_email_2/email': true

end
