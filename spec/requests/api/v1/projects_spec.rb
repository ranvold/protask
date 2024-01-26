# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ProjectsController', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/projects' do
    it 'returns a list of projects' do
      create_list(:project, 3)

      get '/api/v1/projects'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end

    it 'returns projects with tasks when with_tasks parameter is present' do
      create(:project_with_tasks)

      get '/api/v1/projects', params: { with_tasks: true }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first['tasks']).to be_present
    end
  end

  describe 'GET /api/v1/projects/:id' do
    it 'returns a single project' do
      project = create(:project)

      get "/api/v1/projects/#{project.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(project.id)
    end
  end

  describe 'POST /api/v1/projects' do
    it 'creates a new project' do
      project_params = { name: 'New Project', description: 'Description of the project' }

      post '/api/v1/projects', params: { project: project_params }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('New Project')
    end

    it 'returns unprocessable entity on invalid parameters' do
      post '/api/v1/projects', params: { project: { name: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT /api/v1/projects/:id' do
    it 'updates an existing project' do
      project = create(:project)
      updated_name = 'Updated Project'

      put "/api/v1/projects/#{project.id}", params: { project: { name: updated_name } }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(updated_name)
    end

    it 'returns unprocessable entity on invalid parameters' do
      project = create(:project)

      put "/api/v1/projects/#{project.id}", params: { project: { name: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /api/v1/projects/:id' do
    it 'deletes an existing project' do
      project = create(:project)

      expect do
        delete "/api/v1/projects/#{project.id}"
      end.to change(Project, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
