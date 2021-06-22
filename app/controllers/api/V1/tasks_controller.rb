# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :task, only: %i[show destroy update finish]

      def index
        @tasks = Task.paginate(page: params[:page]).order(finished_at: :desc)
        previous_page = @tasks.previous_page
        next_page = @tasks.next_page
        url = request.original_url
        json_response(
          page: @tasks.current_page,
          pages: @tasks.total_pages,
          prev: "#{url}?page=#{previous_page}",
          next: "#{url}?page=#{next_page}",
          tasks: @tasks
        )
      end

      def show
        json_response(task: @task)
      end

      def create
        return if task_description_missing?

        unless avatar_missing?
          command =
            Cloudinary::ImageUploadService.call(task_params)
        end
        task_params[:avatar] = command.result[:image_url] unless command.nil?

        @task = Task.create!(task_params)
        render json: { task: @task }, status: :created
      end

      def update
        @task.update!(task_params)
        json_response(task: @task)
      end

      def finish
        return if task_already_finished?

        @task.finish
        @task.save!
        json_response(task: @task)
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
