FactoryBot.define do
  factory :event do
    name {Faker::Company.name}
    category {Faker::Number.between(from: 0, to: 8)}
    address {Faker::Address.street_address}
    phone {"9287787857"}
    description {Faker::Company.industry}
    vols_required {Faker::Number.between(from: 0, to: 8)}
    start_time {"2022-12-31 13:00"}
    end_time {"2022-12-31 14:00"}
  end
end
