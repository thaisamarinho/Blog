FactoryGirl.define do
  factory :post do
    sequence(:title) {|n| "Hello World #{n}"}
    body {Faker::Hipster.paragraph}
  end
end
