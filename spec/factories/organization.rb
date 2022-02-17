FactoryBot.define do
  factory :organization do
    name {Faker::Company.name}
    location {Faker::Address.city}
    phone {"9287787857"}
    email {Faker::Internet.email}
  end
end
