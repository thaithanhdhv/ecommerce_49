FactoryBot.define do
  factory :product do
    name {Faker::Name.name}
    quantity {Faker::Number.between(1, 10)}
    price {Faker::Number.decimal(2)}
    description {Faker::Lorem.sentence}
  end
end
