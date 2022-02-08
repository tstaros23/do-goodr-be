FactoryBot.define do
  factory :organization do
    name {Faker::Company.name}
    location {Faker::Address.city}
    phone {Faker::PhoneNumber.cell_phone}
    email {Faker::Internet.email}
  end
end
