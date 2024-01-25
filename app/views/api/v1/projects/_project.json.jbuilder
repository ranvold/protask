# frozen_string_literal: true

json.extract! project, :id, :name, :description, :created_at, :updated_at
json.url api_v1_project_url(project, format: :json)
