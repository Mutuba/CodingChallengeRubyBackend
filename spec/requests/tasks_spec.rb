# frozen_string_literal: true

# spec/requests/tasks_spec.rb
require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  # initialize test data
  let!(:tasks) { create_list(:task, 10) }

  let(:task_id) { tasks.first.id }

  #   Test suite for GET /tasks
  describe 'GET /api/v1/tasks' do
    # make HTTP get request before each example
    before { get '/api/v1/tasks', params: {} }

    it 'returns tasks' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tasks/:id
  describe 'GET /api/v1/tasks/:id' do
    before { get "/api/v1/tasks/#{task_id}", params: {} }

    context 'when the task record exists' do
      it 'returns the task' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the task record does not exist' do
      let(:task_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['error']).to match("Couldn't find Task with 'id'=100")
      end
    end
  end

  # Test suite for POST /tasks
  describe 'POST /api/v1/tasks' do
    # valid payload
    let(:file) do
      Rack::Test::UploadedFile.new(Rails.root.join('spec',
                                                   'fixtures', 'files', 'random-image.jpeg'), 'image/jpg')
    end

    let(:valid_attributes) do
      # send json payload
      { description: 'Learn Elm', finished: true, avatar: file }
    end

    let(:invalid_attributes) do
      # send json payload
      { description: nil, finished: true, avatar: file }
    end

    before(:each) do
      allow(Cloudinary::ImageUploadService).to receive(:call).and_return(OpenStruct.new(result: { image_url: 'fake_url' }))
    end
    context 'when the request is valid' do
      before do
        post '/api/v1/tasks', params: valid_attributes
      end
      it 'creates a todo' do
        expect(json['description']).to eq('Learn Elm')
        expect(json['avatar']).to eq('fake_url')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/api/v1/tasks', params: invalid_attributes
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['error'])
          .to eq('task description cannot be blank')
      end
    end
  end

  # Test suite for PUT /tasks/:id
  describe 'PUT /api/v1/tasks/:id' do
    let(:update_attributes) { { finished: true } }

    context 'when the record exists' do
      before { put "/api/v1/tasks/#{task_id}", params: update_attributes }

      it 'updates the record' do
        expect(json['finished']).to eq true
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /tasks/:id
  describe 'DELETE api/v1/tasks/:id' do
    before { delete "/api/v1/tasks/#{task_id}", params: {} }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
