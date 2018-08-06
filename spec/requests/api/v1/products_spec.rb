require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  let!(:user) { FactoryBot.create(:user, :admin, :with_enterprise) }
  let(:enterprise) { user.enterprise }
  let(:header) { { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token } }
  let!(:products_list) { FactoryBot.create_list(:product, 10, enterprise_id: enterprise.id) }
  let(:product) { products_list.first }
  let(:product_params) { FactoryBot.attributes_for(:product, enterprise_id: enterprise.id) }

  describe 'GET /enterprises/products' do
    context 'when havent params' do
      before do
        get(
          api_v1_enterprises_products_path,
          headers: header
        )
      end
  
      it 'returns products collection' do
        data = JSON.parse(response.body)['data']
        expect(data.count).to eq(enterprise.products.count)
      end
    end

    context 'when have room_id param' do
      let!(:rooms_list) { FactoryBot.create_list(:room, 10, enterprise_id: enterprise.id) }
      let(:room) { rooms_list.first }

      before do
        post(
          api_v1_enterprises_room_sale_product_path(room_id: room.id,product_id: product.id),
          headers: header
        )
        post(
          api_v1_enterprises_room_sale_product_path(room_id: room.id,product_id: product.id),
          headers: header
        )
        get(
          api_v1_enterprises_products_path(room_id: room.id),
          headers: header
        )
      end

      it 'returns a rooms product' do
        data = JSON.parse(response.body)['data']
        expect(data.count).to eq(room.products.count)  
      end
    end
  end

  describe 'POST /enterprises/products' do
    before do
      post(
        api_v1_enterprises_products_path,
        params: { product: product_params },
        headers: header
      )
    end

    it 'return enterprise data' do
      data = JSON.parse(response.body)['data']
      expect(data['dni']).to eq(product_params[:dni]) 
    end
  end

  describe 'PATCH /enterprises/products/:id' do
    before do
      patch(
        api_v1_enterprises_product_path(id: product.id),
        params: { product: product_params },
        headers: header
      )
    end

    it 'returns product updated' do
      product.reload
      data = JSON.parse(response.body)['data']
      expect(data['dni']).to eq(product[:dni])
    end
  end
end
