require 'rails_helper'

RSpec.describe "Courses API", type: :request do
  let!(:courses) { create_list(:course, 3) }
  let(:course_id) { courses.first.id }

  describe 'GET /api/courses' do
    before { get '/api/courses' }

    it 'returns courses' do
      expect(json['data'].size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/courses/:id' do
    before { get "/api/courses/#{course_id}" }

    it 'returns the course' do
      expect(json['data']['id']).to eq(course_id.to_s)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/courses' do
    let(:valid_attributes) { { name: 'New Course', description: 'Course Description' } }

    context 'when the request is valid' do
      before { post '/api/courses', params: { course: valid_attributes } }

      it 'creates a course' do
        expect(json['data']['attributes']['name']).to eq('New Course')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/courses', params: { course: { name: nil } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe 'PUT /api/courses/:id' do
    let(:valid_attributes) { { name: 'Updated Course' } }

    before { put "/api/courses/#{course_id}", params: { course: valid_attributes } }

    it 'updates the course' do
      expect(json['data']['attributes']['name']).to eq('Updated Course')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /api/courses/:id' do
    before { delete "/api/courses/#{course_id}" }

    it 'deletes the course' do
      expect(response).to have_http_status(204)
    end
  end

  def json
    JSON.parse(response.body)
  end
end