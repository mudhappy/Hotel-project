require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /users/:id' do
    let!(:user) { FactoryBot.create(:user, :with_enterprise) }

    context 'when user exists' do
      context 'if belongs to a enterprise' do
        before { get api_v1_user_path(user) }

        it 'returns user data' do
          data = JSON.parse(response.body)['data']
          expect(data['email']).to eq(user.email)
          expect(['root', 'admin', 'employee']).to include(data['role'])
          expect(data['enterprise']['id']).to eq(user.enterprise.id)
        end
      end

      context 'if no belongs to a enterprise' do
        let!(:user) { FactoryBot.create(:user, role: 'admin') }
        before { get api_v1_user_path(user) }

        it 'returns alert message in enterprise input' do
          data = JSON.parse(response.body)['data']
          expect(data['enterprise']).to eq('Aun no pertenece a una empresa')
        end
      end
    end

    context 'when user not exists' do
      before { get api_v1_user_path(0) }

      it 'returns 404 status code' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        expect(response.body).to match(/error/)
      end
    end
  end
end
