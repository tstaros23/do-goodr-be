class OrganizationSerializer

  def self.format_single(org)

    {
      type: 'organization',
      data:
          [
            {
            id: org.id,
            name: org.name,
            location: org.location,
            phone: org.phone,
            email: org.email
          }
        ]
    }
  end

  def self.format_multiple(orgs)
    {
      type: 'organization',
      data:
          orgs.map do |obj|
          {
            id: obj.id,
            name: obj.name,
            location: obj.location,
            phone: obj.phone,
            email: obj.email
          }
        end
    }
  end
end
