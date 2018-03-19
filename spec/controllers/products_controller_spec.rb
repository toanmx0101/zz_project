require 'rails_helper'

describe ProductsController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  before(:each) do
    Faker::UniqueGenerator.clear
    @product = FactoryBot.create(:product)
  end
  let(:valid_attributes) { FactoryBot.attributes_for :product }
  let(:invalid_attributes) do
    { name: nil }
  end

  it 'populates an array of products' do
    get :index
    expect(assigns(:products)).to eq([@product])
  end

  it 'renders the :index view' do
    get :index
    expect(response).to have_http_status(:success)
  end

  it 'populates a product' do
    get :show, params: { id: @product.id }
    expect(assigns(:product)).to eq(@product)
  end

  it 'populates a product' do
    get :index, params: { sort_column: 'price', sort_type: 'DESC' }
    @sorted_product = Product.all.order(price: :DESC)
    expect(assigns(:products).map(&:id)).to eq(@sorted_product.map(&:id))
  end

  it 'renders the :search view' do
    get :search
    expect(response).to have_http_status(:success)
  end

  describe 'GET new' do
    it 'returns http success' do
      user = FactoryBot.create(:user)
      sign_in(user)
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'assigns the product' do
      user = FactoryBot.create(:user)
      sign_in(user)
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe 'POST create' do
    before(:each) do
      sign_in(FactoryBot.create(:user))
    end
    let(:valid_attributes) { FactoryBot.attributes_for :product }
    let(:invalid_attributes) do
      { name: nil }
    end
    context 'with valid params' do
      it 'creates a new product' do
        expect { post :create, params: { product: valid_attributes } }.to change(Product, :count).by(1)
      end

      it 'assigns a newly created product as @product' do
        post :create, params: { product: valid_attributes }
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it 'redirects to the created product' do
        post :create, params: { product: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(product_path(Product.last))
      end

      it 'should create the product' do
        post :create, params: { product: valid_attributes }
        product = Product.last

        expect(product.name).to eq(valid_attributes[:name])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { product: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved product as @product' do
        post :create, params: { product: invalid_attributes }
        expect(assigns(:product)).to be_a_new(Product)
      end

      it 'invalid_attributes do not create a product' do
        expect do
          post :create, params: { product: invalid_attributes }
        end.not_to change(Product, :count)
      end
    end
  end

  describe 'GET edit' do
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in(@user)
      @user_product = FactoryBot.create(:product, user_id: @user.id)
    end
    before do
      get :edit, params: { id: @user_product.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the product' do
      expect(assigns(:product)).to eq(@user_product)
    end
  end
  describe 'PUT update' do
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in(@user)
      @user_product = FactoryBot.create(:product, user_id: @user.id)
    end
    context 'with valid params' do
      before do
        put :update, params: { id: @user_product.id, product: valid_attributes }
      end
      it 'assigns the product' do
        expect(assigns(:product)).to eq(@user_product)
      end
      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(product_path(@user_product))
      end
      it 'should update the product' do
        @user_product.reload
        expect(@user_product.name).to eq(valid_attributes[:name])
      end
    end
    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: @user_product.id, product: invalid_attributes }
        expect(response).to have_http_status(:success)
      end
      it 'does not change user_product' do
        put :update, params: { id: @user_product.id, product: invalid_attributes }
        expect { response }.to_not change { @user_product.reload.name }
      end
    end
    context 'with not own product' do
      it 'returns http success' do
        not_own_product_user = FactoryBot.create(:user)
        put :update, params: { format: :json, id: not_own_product_user.id, product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'does not change user_product' do
        put :update, params: { id: @user_product.id, product: invalid_attributes }
        expect { response }.to_not change { @user_product.reload.name }
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in(@user)
      @user_product = FactoryBot.create(:product, user_id: @user.id)
    end
    it 'destroys the requested select_option' do
      expect { delete :destroy, params: { id: @user_product.id } }.to change(Product, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: @user_product.id }
      expect(response).to redirect_to(products_path)
    end

    it 'returns http error' do
      not_own_product = FactoryBot.create(:product)
      delete :destroy, params: { format: :json, id: not_own_product.id }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
