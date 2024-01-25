# frozen_string_literal: true

json.extract! task, :id, :name, :description, :status, :project_id, :created_at, :updated_at
json.url api_v1_project_task_url(task.project, task, format: :json)
