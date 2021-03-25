class TasksController < ApplicationController

  before_action :set_task, only: %i[show destroy update]

  def index
    @tasks = Task.order('created_at DESC')
    json_response(@tasks)
  end

  def show
    json_response(@task)
  end

  def create
    return if avatar_missing?

    command =
      Cloudinary::ImageUploadService.call(task_params)
    task_params[:avatar] = command.result[:image_url]

    @task = Task.new(task_params)
    if @task.save
      json_response(@task, 201)
    else
      json_response(@task.errors, 422)
    end
  end

  def update
    if @task.update_attributes(task_params)
      json_response(@task, 200)
    else
      json_response(@task.errors, 422)
    end
  end

  def destroy
    @task.destroy
    head :no_content, status: :ok
  end

  private

  def set_task
    @task ||= Task.find(params[:id])
  end

  def task_params
    @_task_params ||= params.permit(:description, :avatar, :finished)
  end

  def avatar_missing?
    if params[:avatar].nil? || params[:avatar].blank?
      render json: {
        error: 'avatar_url cannot be blank'
      }, status: :unprocessable_entity
    end
  end
end
