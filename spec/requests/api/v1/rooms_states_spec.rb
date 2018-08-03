require 'rails_helper'

RSpec.describe "Api::V1::RoomStates", type: :request do
  let!(:user) { FactoryBot.create(:user, :admin, :with_enterprise) }
  let(:enterprise) { user.enterprise }
  let(:rooms_state_params) { FactoryBot.attributes_for(:rooms_state) }
  let(:header){ { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token } }

  describe 'POST /enterprises/rooms_states' do
    before do
      post(
        api_v1_enterprises_rooms_states_path,
        headers: header,
        params: { rooms_state: rooms_state_params }
      )
    end
    
    it 'returns rooms state data' do
      data = JSON.parse(response.body)['data']
      expect(data['name']).to eq(rooms_state_params[:name])
    end
  end
end
