require 'rails_helper'

RSpec.describe 'Api::V1::RoomsTypes', type: :request do
  let!(:user){ FactoryBot.create(:user, :admin, :with_enterprise) }
  let(:enterprise){ user.enterprise }
  let(:header){ { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token } }
  let!(:rooms_types){ FactoryBot.create_list(:rooms_type, 3, enterprise_id: enterprise.id) }
  let(:rooms_type_params){ FactoryBot.attributes_for(:rooms_type) }
  
  describe 'GET /enterprises/rooms_types' do
    before do
      get(
        api_v1_enterprises_rooms_types_path,
        headers: header
        )
    end
    
    it 'returns data collection' do
      data = JSON.parse(response.body)['data']
      expect(enterprise.rooms_types.count).to eq(data.count)
    end
  end

  describe 'POST /enterprises/rooms_types' do
    before do
      post(
        api_v1_enterprises_rooms_types_path,
        params: { rooms_type: rooms_type_params },
        headers: header
      )
    end

    it 'returns rooms_type data' do
      data = JSON.parse(response.body)['data']
      expect(data['name']).to eq(rooms_type_params[:name])
    end
  end

  describe 'PATCH /enterprise/rooms_type/:id' do
    context 'when user belongs to the enterprise' do
      let!(:rooms_type){ rooms_types.first }
      before do
        patch(
          api_v1_enterprises_rooms_type_path(id: rooms_type.id),
          headers: header,
          params: { rooms_type: rooms_type_params }
        )
      end

      it 'returns data update' do
        rooms_type.reload
        data = JSON.parse(response.body)['data']
        expect(data['name']).to eq(rooms_type[:name])
      end
    end

    context 'when user no belongs to the enterprise' do
      let!(:rooms_type){ rooms_types.first }
      let!(:other_user){ FactoryBot.create(:user, :admin, :with_enterprise) }
      let!(:other_header){ { 'X-User-Email': other_user.email, 'X-User-Token': other_user.authentication_token } }
      before do
        patch(
          api_v1_enterprises_rooms_type_path(id: rooms_type.id),
          headers: other_header,
          params: { rooms_type: rooms_type_params }
        )
      end

      it 'returns error message' do
        expect(response.body).to match(/error/)
      end
    end
  end
end
