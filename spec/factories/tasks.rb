# frozen_string_literal: true

# spec/factories/todos.rb
FactoryBot.define do
  factory :task do
    description { Faker::Quotes::Shakespeare.hamlet_quote }
    avatar { Faker::Internet.url }
    finished { true }
  end
end
