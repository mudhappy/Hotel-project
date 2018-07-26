require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let!(:user){ FactoryBot.create(:user, :with_enterprise) }
  let(:user_params){ FactoryBot.attributes_for(:user) }

  describe 'POST /api_v1_sessions' do
    context 'when user params are correct' do
      before do
        post(
          api_v1_sessions_path,
          params: { email: user.email, password: user.password }
        )
      end

      it 'returns 201 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'returns a user data' do
        data = JSON.parse(response.body)['data']
        expect(data['email']).to eq(user.email)
      end
    end

    context 'when user params are incorrect' do
      before { post(api_v1_sessions_path, params: user_params) }

      it 'returns 401 status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
