require 'rails_helper'

describe HomeController do
  it 'blocks unauthenticated access' do
    get :home
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'allows authenticated access' do
    user = FactoryBot.create(:user)
    sign_in user
    get :home
    expect(response).to render_template :home
  end
end
