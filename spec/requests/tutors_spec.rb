require 'rails_helper'

RSpec.describe "Tutors API", type: :request do
  let!(:course) { create(:course) }
  let!(:tutors) { create_list(:tutor, 3, course: course) }
  let(:course_id) { course.id }
  let(:tutor_id) { tutors.first.id }

  describe 'GET /api/courses/:course_id/tutors' do
    before { get "/api/courses/#{course_id}/tutors" }

    it 'returns tutors for the course' do
      expect(json['data'].size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/courses/:course_id/tutors/:id' do
    before { get "/api/courses/#{course_id}/tutors/#{tutor_id}" }

    it 'returns the tutor' do
      expect(json['data']['id']).to eq(tutor_id.to_s)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/courses/:course_id/tutors' do
    let(:valid_attributes) { { name: 'New Tutor', email: 'new.tutor@example.com' } }

    context 'when the request is valid' do
      before { post "/api/courses/#{course_id}/tutors", params: { tutor: valid_attributes } }

      it 'creates a tutor' do
        expect(json['data']['attributes']['first_name','last_name']).to eq('New Tutor')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/api/courses/#{course_id}/tutors", params: { tutor: { name: nil } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe 'PUT /api/courses/:course_id/tutors/:id' do
    let(:valid_attributes) { { name: 'Updated Tutor' } }

    before { put "/api/courses/#{course_id}/tutors/#{tutor_id}", params: { tutor: valid_attributes } }

    it 'updates the tutor' do
      expect(json['data']['attributes']['name']).to eq('Updated Tutor')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /api/courses/:course_id/tutors/:id' do
    before { delete "/api/courses/#{course_id}/tutors/#{tutor_id}" }

    it 'deletes the tutor' do
      expect(response).to have_http_status(204)
    end
  end

  def json
    JSON.parse(response.body)
  end
end