# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[show update destroy]

      def index
        @tasks = Task.where(project: params[:project_id])
      end

      def show; end

      def create
        @task = Task.new(task_params)

        if @task.save
          render :show, status: :created, location: api_v1_project_task_url(@task.project, @task)
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render :show, status: :ok, location: api_v1_project_task_url(@task.project, @task)
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy!
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:name, :description, :status, :project_id)
      end
    end
  end
end
