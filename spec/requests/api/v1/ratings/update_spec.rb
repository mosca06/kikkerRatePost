require 'rails_helper'

RSpec.describe 'Ratings API - Update', type: :request do
  describe 'PATCH /api/v1/ratings/:id' do
    let(:user) { create(:user) }
    let(:post_record) { create(:post, user: user) }
    let(:rating) { create(:rating, user: user, post: post_record, value: 3) }

    context 'with valid params' do
      it 'updates the rating' do
        patch "/api/v1/ratings/#{rating.id}", params: { value: 4 }, as: :json

        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body
        expect(json_response['rating']['new_value']).to eq(4)
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        patch "/api/v1/ratings/#{rating.id}", params: { rating: { value: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = response.parsed_body
        expect(json_response).to have_key('errors')
      end
    end
  end
end
