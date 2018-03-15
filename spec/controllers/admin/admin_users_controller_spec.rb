require 'rails_helper'

RSpec.describe Admin::AdminUsersController, type: :controller do
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) }
  let(:user) { FactoryBot.create(:admin_user) }
  before { sign_in user }
  let!(:admin_user) { 
    FactoryBot.create(:admin_user) 
  }
  let(:valid_attributes) do
    FactoryBot.attributes_for :admin_user
  end

  let(:invalid_attributes) do
    { email: '' }
  end

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the admin users' do
      get :index
      expect(assigns(:admin_users)).to include(admin_user)
    end

    it 'should render the expected columns' do
      get :index
      expect(page).to have_content(admin_user.email)
      expect(page).to have_content(admin_user.current_sign_in_at)
      expect(page).to have_content(admin_user.sign_in_count)
    end

    let(:filters_sidebar) { page.find('#filters_sidebar_section') }
    it 'filter email exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_email"]', text: 'Email')
      expect(filters_sidebar).to have_css('input[name="q[email_contains]"]')
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'assigns the admin_user' do
      get :new
      expect(assigns(:admin_user)).to be_a_new(AdminUser)
    end
    it 'should render the form elements' do
      get :new
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_field('Password confirmation')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new admin user' do
        expect { post :create, params: { admin_user: valid_attributes } }.to change(AdminUser, :count).by(1)
      end

      it 'assigns a newly created admin user as @admin_user' do
        post :create, params: { admin_user: valid_attributes }
        expect(assigns(:admin_user)).to be_a(AdminUser)
        expect(assigns(:admin_user)).to be_persisted
      end

      it 'redirects to the created admin user' do
        post :create, params: { admin_user: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_admin_user_path(AdminUser.last))
      end

      it 'should create the admin user' do
        post :create, params: { admin_user: valid_attributes }
        admin_user = AdminUser.last

        expect(admin_user.email).to eq(valid_attributes[:email])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { admin_user: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved admin_user as @admin_user' do
        post :create, params: { admin_user: invalid_attributes }
        expect(assigns(:admin_user)).to be_a_new(AdminUser)
      end

      it 'invalid_attributes do not create a AdminUser' do
        expect do
          post :create, params: { admin_user: invalid_attributes }
        end.not_to change(AdminUser, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: admin_user.id }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'assigns the admin_user' do
      expect(assigns(:admin_user)).to eq(admin_user)
    end
    it 'should render the form elements' do
      expect(page).to have_field('Email', with: admin_user.email)
      expect(page).to have_field('Password')
      expect(page).to have_field('Password confirmation')
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: admin_user.id, admin_user: valid_attributes }
      end
      it 'assigns the admin_user' do
        expect(assigns(:admin_user)).to eq(admin_user)
      end
      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_admin_user_path(admin_user))
      end
      it 'should update the admin_user' do
        admin_user.reload
        expect(admin_user.email).to eq(valid_attributes[:email])
      end
    end
    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: admin_user.id, admin_user: invalid_attributes }
        expect(response).to have_http_status(:success)
      end
      it 'does not change admin_user' do
        put :update, params: { id: admin_user.id, admin_user: invalid_attributes }
        expect { response }.to_not change { admin_user.reload.email }
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect { delete :destroy, params: { id: admin_user.id } }.to change(AdminUser, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: admin_user.id }
      expect(response).to redirect_to(admin_admin_users_path)
    end
  end
end
