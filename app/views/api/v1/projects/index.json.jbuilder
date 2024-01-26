# frozen_string_literal: true

if params[:with_tasks]
  json.array! @projects, partial: 'api/v1/projects/projects_with_tasks', as: :project_with_tasks
else
  json.array! @projects, partial: 'api/v1/projects/project', as: :project
end
