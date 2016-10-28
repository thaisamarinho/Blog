# 100.times do
#   Post.create({ title: Faker::Hipster.sentence,
#                 body: Faker::Lorem.paragraph })
#
# end

10.times do
  Category.create({ title: Faker::Commerce.department })
end
