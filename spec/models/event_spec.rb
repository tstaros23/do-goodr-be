require 'rails_helper'

RSpec.describe Event, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :category }
    it { should validate_presence_of :address }
    it { should validate_presence_of :description }
    it { should validate_presence_of :vols_required }
  end

  describe 'relationships' do
    it { should belong_to(:organization) }
  end

end
