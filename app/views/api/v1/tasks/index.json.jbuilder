# frozen_string_literal: true

json.array! @tasks, partial: 'api/v1/tasks/task', as: :task
