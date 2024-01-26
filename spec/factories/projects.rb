# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::App.unique.name }

    factory :project_with_tasks, class: 'Project' do
      transient do
        tasks_count { 3 }
      end

      after(:create) do |project, evaluator|
        create_list(:task, evaluator.tasks_count, project:)
      end
    end
  end
end
