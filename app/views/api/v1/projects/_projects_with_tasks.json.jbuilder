# frozen_string_literal: true

json.id project_with_tasks.id
json.name project_with_tasks.name
json.description project_with_tasks.description
json.created_at project_with_tasks.created_at
json.updated_at project_with_tasks.updated_at
json.url api_v1_project_url(project_with_tasks, format: :json)

json.tasks do
  json.array! project_with_tasks.tasks do |task|
    json.id task.id
    json.name task.name
    json.description task.description
    json.created_at task.created_at
    json.updated_at task.updated_at
    json.url api_v1_project_task_url(task.project, task, format: :json)
  end
end
