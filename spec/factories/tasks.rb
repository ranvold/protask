# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { Faker::Hacker.say_something_smart }
    status { rand(0..2) }
    project
  end
end
