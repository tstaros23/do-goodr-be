require 'rails_helper'

RSpec.describe OrganizationSerializer, type: :serializer do

  describe '.format_single' do
    it 'returns a serialized hash' do
      organization = create(:organization)

      organization_hash = OrganizationSerializer.format_single(organization)

      expect(organization_hash).to be_a(Hash)
      expect(organization_hash).to have_key(:type)

      expect(organization_hash).to have_key(:data)
      expect(organization_hash[:data].size).to eq(1)
      expect(organization_hash[:data].first).to have_key(:id)
      expect(organization_hash[:data].first).to have_key(:name)
      expect(organization_hash[:data].first).to have_key(:location)
      expect(organization_hash[:data].first).to have_key(:phone)
      expect(organization_hash[:data].first).to have_key(:email)
    end
  end

  describe '.format_multiple' do
    it 'returns a serialized hash' do
      organization1 = create(:organization)
      organization2 = create(:organization)
      organization3 = create(:organization)

      organization_hash = OrganizationSerializer.format_multiple([organization1,organization2,organization3])

      expect(organization_hash).to be_a(Hash)
      expect(organization_hash).to have_key(:type)

      expect(organization_hash).to have_key(:data)
      expect(organization_hash[:data].size).to eq(3)
      expect(organization_hash[:data].first).to have_key(:id)
      expect(organization_hash[:data].first).to have_key(:name)
      expect(organization_hash[:data].first).to have_key(:location)
      expect(organization_hash[:data].first).to have_key(:email)
      expect(organization_hash[:data].first).to have_key(:phone)
    end
  end
end
