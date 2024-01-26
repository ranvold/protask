# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::TasksController', type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/projects/:project_id/tasks' do
    it 'returns a list of tasks for a specific project' do
      create_list(:task, 3, project:)

      get "/api/v1/projects/#{project.id}/tasks"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end

    it 'returns tasks with a specific status' do
      create_list(:task, 3, project:, status: :in_progress)

      get "/api/v1/projects/#{project.id}/tasks", params: { status: :in_progress }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end

  describe 'GET /api/v1/projects/:project_id/tasks/:id' do
    it 'returns a single task for a specific project' do
      task = create(:task, project:)

      get "/api/v1/projects/#{project.id}/tasks/#{task.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(task.id)
    end
  end

  describe 'POST /api/v1/projects/:project_id/tasks' do
    it 'creates a new task for a specific project' do
      task_params = { name: 'New Task', description: 'Description of the task', status: :ready_to_go,
                      project_id: project.id }

      post "/api/v1/projects/#{project.id}/tasks", params: { task: task_params }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('New Task')
    end

    it 'returns unprocessable entity on invalid parameters' do
      post "/api/v1/projects/#{project.id}/tasks", params: { task: { name: '', project_id: project.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT /api/v1/projects/:project_id/tasks/:id' do
    it 'updates an existing task for a specific project' do
      task = create(:task, project:)
      updated_name = 'Updated Task'

      put "/api/v1/projects/#{project.id}/tasks/#{task.id}",
          params: { task: { name: updated_name, project_id: project.id } }

      expect(JSON.parse(response.body)['name']).to eq(updated_name)
    end

    it 'returns unprocessable entity on invalid parameters' do
      task = create(:task, project:)

      put "/api/v1/projects/#{project.id}/tasks/#{task.id}", params: { task: { name: '', project_id: project.id } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /api/v1/projects/:project_id/tasks/:id' do
    it 'deletes an existing task for a specific project' do
      task = create(:task, project:)

      expect do
        delete "/api/v1/projects/#{project.id}/tasks/#{task.id}"
      end.to change(Task, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
