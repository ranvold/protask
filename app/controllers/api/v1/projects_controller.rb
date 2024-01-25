# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_project, only: %i[show update destroy]

      def index
        @projects = params[:with_tasks].present? ? Project.includes(:tasks) : Project.all
      end

      def show; end

      def create
        @project = Project.new(project_params)

        if @project.save
          render :show, status: :created, location: api_v1_project_url(@project)
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      def update
        if @project.update(project_params)
          render :show, status: :ok, location: api_v1_project_url(@project)
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @project.destroy!
      end

      private

      def set_project
        @project = Project.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name, :description)
      end
    end
  end
end
