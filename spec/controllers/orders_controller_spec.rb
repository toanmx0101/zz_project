require 'rails_helper'

describe OrdersController, type: :controller do
  context 'unauthenticated user' do
    it 'blocks unauthenticated access' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'authenticated user' do
    before(:each) do
      Faker::UniqueGenerator.clear
      @user = FactoryBot.create(:user)
      sign_in @user
      @order = FactoryBot.create(:order, user_id: @user.id)
    end

    it 'populates an array of orders' do
      get :index
      expect(assigns(:orders)).to eq([@order])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end

    it 'get an array of products' do
      get :show, params: { id: @order.id }
      expect(assigns(:order)).to eq(@order)
    end

    it 'renders the :show view' do
      get :show, params: { id: @order.id }
      expect(response).to render_template :show
    end

    it 'creates a new order with valid attributes' do
      allow(controller).to receive(:current_user) { @user }
      first_product = FactoryBot.create(:product)
      order = FactoryBot.create(:order, user_id: @user.id, total_price: first_product.price)
      valid_order_details_params = { first_product.id => 1 }
      post :create, params: { format: :json, order: order, order_details: valid_order_details_params }
      expect(response).to have_http_status(:success)
    end

    it 'creates a new order with invalid attributes' do
      allow(controller).to receive(:current_user) { @user }
      invalid_order_details_params = nil
      post :create, params: { format: :json, order: invalid_order_details_params, order_details: invalid_order_details_params }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
