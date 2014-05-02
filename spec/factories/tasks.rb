FactoryGirl.define do
  factory :task do
    name {Faker::Lorem.sentence}
    priority {Faker::Number.number(1)}
    complete true
  end
end