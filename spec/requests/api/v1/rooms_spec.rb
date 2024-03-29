require 'rails_helper'

RSpec.describe 'Api::V1::Rooms', type: :request do
  let!(:user) { FactoryBot.create(:user, :employee, :with_enterprise) }
  let(:enterprise) { user.enterprise }
  let!(:rooms_types) { FactoryBot.create_list(:rooms_type, 3, enterprise_id: enterprise.id) }
  let!(:rooms_states) { FactoryBot.create_list(:rooms_state, 3, enterprise_id: enterprise.id) }
  let(:room_params) { 
    FactoryBot.attributes_for(
      :room,
      enterprise_id: enterprise.id,
      rooms_type_id: rooms_types.first.id,
      rooms_state_id: rooms_states.first.id
    )}
  let!(:rooms_list){ 
    FactoryBot.create_list(
      :room,
      3,
      enterprise_id: enterprise.id,
      rooms_type_id: rooms_types.first.id,
      rooms_state_id: rooms_states.first.id
  )}
  let!(:rooms_list_2){ 
    FactoryBot.create_list(
      :room,
      3,
      enterprise_id: enterprise.id,
      rooms_type_id: rooms_types.first.id,
      rooms_state_id: rooms_states.second.id
  )}
  let!(:rooms_list_3){ 
    FactoryBot.create_list(
      :room,
      3,
      enterprise_id: enterprise.id,
      rooms_type_id: rooms_types.second.id,
      rooms_state_id: rooms_states.first.id
  )}
  let(:room) { rooms_list.first }
  let(:header) { { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token } }
  let!(:product){ FactoryBot.create(:product, enterprise_id: enterprise.id, quantity: 4) }

  describe 'POST /enterprises/rooms' do
    context 'when user is employee' do
      let!(:user){ FactoryBot.create(:user, :employee, :with_enterprise) }
      before do
        post(
          api_v1_enterprises_rooms_path,
          params: { room: room_params },
          headers: header
        )
      end
  
      it 'returns room data' do
        data = JSON.parse(response.body)['data']
        expect(data['price']).to eq(room_params[:price])
      end
    end

    context 'when user is admin' do
      let!(:user){ FactoryBot.create(:user, :admin, :with_enterprise) }
      before do
        post(
          api_v1_enterprises_rooms_path,
          params: { room: room_params },
          headers: header
        )
      end
  
      it 'returns room data' do
        data = JSON.parse(response.body)['data']
        expect(data['price']).to eq(room_params[:price])
      end
    end
  end

  describe 'PATCH /enterprises/rooms' do
    before do
      patch(
        api_v1_enterprises_room_path(id: room.id),
        params: { room: room_params },
        headers: header
      )
    end

    it 'returns updated data' do
      room.reload
      data = JSON.parse(response.body)['data']
      expect(data['price']).to eq(room_params[:price])
    end
  end

  describe 'GET /enterprises/rooms?rooms_state_id&rooms_state_id' do
    context 'when all rooms are requested' do
      before do
        get(
          api_v1_enterprises_rooms_path,
          headers: header
        )
      end
  
      it 'get a rooms collection' do
        data = JSON.parse(response.body)['data']
        expect(data.count).to eq(enterprise.rooms.count)
      end
    end

    context 'when specific rooms are requested' do
      before do
        get(
          api_v1_enterprises_rooms_path,
          params: { rooms_state_id: rooms_states.second.id },
          headers: header
        )
      end

      it 'get a rooms collection' do
        data = JSON.parse(response.body)['data']
        expect(data.count).to eq(enterprise.get_rooms(nil, rooms_states.second.id).count)
      end
    end
  end

  describe 'GET /enterprises/room/:id' do
    before do
      get(
        api_v1_enterprises_room_path(id: room.id),
        headers: header
      )
    end

    it 'return room data' do
      data = JSON.parse(response.body)['data']
      expect(data['price']).to eq(room[:price].to_s)
    end
  end

  describe 'POST /enterprises/rooms/:room_id/sale_product' do
    context 'if stock' do
      before do
        post(
          api_v1_enterprises_room_sale_product_path(
            room_id: room.id,
            product_id: product.id
          ),
          headers: header
        )
      end

      it 'returns ok status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'add a product to room' do
        expect(room.products.count).to eq(1)
      end
  
      it 'less products cuantities' do
        product.reload
        expect(product[:quantity]).to eq(3)
      end
    end

    context 'if not stock' do
      let!(:product){ FactoryBot.create(:product, enterprise_id: enterprise.id, quantity: 0) }
      before do
        post(
          api_v1_enterprises_room_sale_product_path(
            room_id: room.id,
            product_id: product.id
          ),
          headers: header
        )
      end

      it 'returns unprocessable entity status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'no add product' do
        expect(room.products.count).to eq(0)
      end
  
      it 'return error message' do
        expect(response.body).to match(/error/)
      end
    end
  end
end
