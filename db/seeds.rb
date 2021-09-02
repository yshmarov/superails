# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# rubocop: disable Style/NumericLiterals
5.times do
  user = User.create(
    email: Faker::Internet.email,
    name: Faker::Artist.name,
    password: 123456
  )
  rand(0..5).times do
    Post.create(
      title: Faker::Lorem.sentence(word_count: 5),
      description: Faker::Lorem.sentence(word_count: 15),
      body: Faker::Markdown.sandwich(sentences: 50),
      user: user,
      premium: [true, false].sample)
  end
end
p "#{User.count} users created"
p "#{Post.count} posts created"
# rubocop: enable Style/NumericLiterals