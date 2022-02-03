require 'rails_helper'

RSpec.describe Organization, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :email }
  end

  describe 'relationships' do
    it { should have_many(:events) }
  end

end
