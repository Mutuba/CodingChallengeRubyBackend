# frozen_string_literal: true

# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  # initialize test data
  #   let!(:todos) { create_list(:todo, 10, created_by: user.id) }

  #   let(:todo_id) { todos.first.id }
  #   let(:headers) { valid_headers }

  # Test suite for GET /todos
  #   describe 'GET /api/v1/todos' do
  #     # make HTTP get request before each example
  #     before { get '/api/v1/todos', params: {}, headers: headers }

  #     it 'returns todos' do
  #       # Note `json` is a custom helper to parse JSON responses
  #       expect(json).not_to be_empty
  #       expect(json.size).to eq(10)
  #     end

  #     it 'returns status code 200' do
  #       expect(response).to have_http_status(200)
  #     end
  #   end

  #   # Test suite for GET /todos/:id
  #   describe 'GET /api/v1/todos/:id' do
  #     before { get "/api/v1/todos/#{todo_id}", params: {}, headers: headers }

  #     context 'when the record exists' do
  #       it 'returns the todo' do
  #         expect(json).not_to be_empty
  #         expect(json['id']).to eq(todo_id)
  #       end

  #       it 'returns status code 200' do
  #         expect(response).to have_http_status(200)
  #       end
  #     end

  #     context 'when the record does not exist' do
  #       let(:todo_id) { 100 }

  #       it 'returns status code 404' do
  #         expect(response).to have_http_status(404)
  #       end

  #       it 'returns a not found message' do
  #         expect(response.body).to match(/Couldn't find Todo with 'id'=100/)
  #       end
  #     end
  #   end

  # Test suite for POST /todos
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

  #   # Test suite for PUT /todos/:id
  #   describe 'PUT /api/v1/todos/:id' do
  #     let(:valid_attributes) { { title: 'Shopping' }.to_json }

  #     context 'when the record exists' do
  #       before { put "/api/v1/todos/#{todo_id}", params: valid_attributes, headers: headers }

  #       it 'updates the record' do
  #         expect(response.body).to be_empty
  #       end

  #       it 'returns status code 204' do
  #         expect(response).to have_http_status(204)
  #       end
  #     end
  #   end

  #   # Test suite for DELETE /todos/:id
  #   describe 'DELETE api/v1/todos/:id' do
  #     before { delete "/api/v1/todos/#{todo_id}", params: {}, headers: headers }

  #     it 'returns status code 204' do
  #       expect(response).to have_http_status(204)
  #     end
  #   end
end
