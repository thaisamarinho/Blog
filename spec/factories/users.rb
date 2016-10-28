FactoryGirl.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.email}
    sequence(:email) {|n| Faker::Internet.email.gsub('@', "-#{n}@")}
    password_digest {Faker::Internet.password}
  end
end
