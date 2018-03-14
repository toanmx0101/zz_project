require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before { sign_in admin_user }
  let(:product) do
    Faker::UniqueGenerator.clear
    FactoryBot.create(:product)
  end
  let(:valid_attributes) { FactoryBot.attributes_for :product }
  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the product' do
      get :index
      expect(assigns(:products)).to include(product)
    end

    it 'should render the expected columns' do
      Faker::UniqueGenerator.clear
      c_example = FactoryBot.create(:product)
      get :index
      expect(page).to have_content(c_example.name)
      expect(page).to have_content(c_example.description)
      expect(page).to have_content(c_example.price)
    end

    let(:filters_sidebar) { page.find('#filters_sidebar_section') }
    it 'filter email exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_name"]', text: 'Name')
      expect(filters_sidebar).to have_css('input[name="q[name_contains]"]')
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'assigns the product' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
    it 'should render the form elements' do
      get :new
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
    end
  end

  describe 'POST create' do
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
        expect(response).to redirect_to(admin_product_path(Product.last))
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
    before do
      get :edit, params: { id: product.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the product' do
      expect(assigns(:product)).to eq(product)
    end
    it 'should render the form elements' do
      expect(page).to have_field('Name', with: product.name)
      expect(page).to have_field('Description', with: product.description)
      expect(page).to have_field('Price', with: product.category_id)
    end
  end

  # describe 'PUT update' do
  #   context 'with valid params' do
  #     before do
  #       put :update, params: { id: product.id, product: valid_attributes }
  #     end
  #     it 'assigns the product' do
  #       expect(assigns(:product)).to eq(product)
  #     end
  #     it 'returns http redirect' do
  #       expect(response).to have_http_status(:redirect)
  #       expect(response).to redirect_to(admin_product_path(product))
  #     end
  #     it 'should update the product' do
  #       product.reload
  #       expect(product.email).to eq(valid_attributes[:name])
  #     end
  #   end
  #   context 'with invalid params' do
  #     it 'returns http success' do
  #       put :update, params: { id: admin_user.id, admin_user: invalid_attributes }
  #       expect(response).to have_http_status(:success)
  #     end
  #     it 'does not change admin_user' do
  #       put :update, params: { id: admin_user.id, admin_user: invalid_attributes }
  #       expect { response }.to_not change{ admin_user.reload.email }
  #     end
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   it 'destroys the requested select_option' do
  #     expect { delete :destroy, params: { id: admin_user.id } }.to change(AdminUser, :count).by(-1)
  #   end

  #   it 'redirects to the field' do
  #     delete :destroy, params: { id: admin_user.id }
  #     expect(response).to redirect_to(admin_admin_users_path)
  #   end
  # end
end
