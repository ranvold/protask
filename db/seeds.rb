# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(email: 'test@protask.io', password: 'password', password_confirmation: 'password')

3.times do
  project = Project.find_or_create_by!(name: Faker::App.unique.name)
  3.times do
    Task.find_or_create_by!(
      name: Faker::Hacker.say_something_smart,
      status: rand(0..2),
      project:
    )
  end
end
