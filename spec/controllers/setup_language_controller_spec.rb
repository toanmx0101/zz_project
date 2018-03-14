require 'rails_helper'

RSpec.describe SetupLanguageController, type: :controller do
  before(:each) do
    request.env["HTTP_REFERER"] = root_path
  end

  it 'GET #english rederect back' do
    get :english
    expect(response).to redirect_to root_path
  end
  it 'GET #english rederect back' do
    get :vietnam
    expect(response).to redirect_to root_path
  end
end
