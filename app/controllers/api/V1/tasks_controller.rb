# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :task, only: %i[show destroy update finish]

      def index
        @tasks = Task.order(finished_at: :desc)
        json_response(@tasks)
      end

      def show
        json_response(@task)
      end

      def create
        return if task_description_missing?

        unless avatar_missing?
          command =
            Cloudinary::ImageUploadService.call(task_params)
        end
        task_params[:avatar] = command.result[:image_url] unless command.nil?

        @task = Task.create!(task_params)
        json_response(@task, 201)
      end

      def update
        @task.update!(task_params)
        json_response(@task, 200)
      end

      def finish
        return if task_already_finished?

        @task.finish
        if @task.save!
          json_response(@task, 200)
        else
          json_response(@task.errors, 422)
        end
      end

      def destroy
        @task.destroy!
        head :no_content, status: :ok
      end

      private

      def task
        @task = Task.find(params[:id])
      end

      def task_params
        @task_params ||= params.permit(:description, :avatar, :finished)
      end

      def finish_task_param
        {
          finished: true
        }
      end

      def task_already_finished?
        render json: { conflict: 'task has already been completed' }, status: 409 if @task.finished
      end

      def avatar_missing?
        params[:avatar].nil? || params[:avatar].blank?
      end

      def task_description_missing?
        return unless params[:description].nil? || params[:description].blank?

        render json: { error: 'task description cannot be blank' }, status: 422
      end
    end
  end
end
