require 'rails_helper'

describe HomeController do
  it 'blocks unauthenticated access' do
    get :home
    expect(response).to redirect_to(new_user_session_path)
  end

  describe 'Authenticated access' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    it 'GET :home' do
      get :home
      expect(response).to render_template :home
    end

    it 'List products' do
      get :home
      expect(assigns(:products)).to eq(@user.products)
    end

    it 'GET :who_purchased' do
      get :who_purchased
      expect(response).to have_http_status(:success)
    end

    # it 'List who purchased products' do
    #   get :who_purchased
    #   expect(assigns(:user_purchased_orders)).to eq(OrderDetail.who_purchased_products(@user))
    # end
  end
end
