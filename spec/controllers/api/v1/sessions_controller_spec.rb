require 'rails_helper'

require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let(:user_params){ FactoryBot.attributes_for(:user) }
  
  describe 'POST /api_v1_sessions' do
    context 'when user exists' do
      before{ post(api_v1_sessions_path, params:{ email: user.email, password: user.password }) }

      it 'returns created status code' do
        expect(response).to have_http_status(:created)
      end
    end
    
    context 'when user no exists' do
      before{ post(api_v1_sessions_path, params: user_params ) }

      it 'returns unauthorized status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

end
