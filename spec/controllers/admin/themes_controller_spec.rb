require 'rails_helper'
require './spec/shared_contexts/site_setup.rb'

RSpec.describe Admin::ThemesController, type: :controller do
  include_context "site setup"

  describe "GET #index" do
    context 'with user not signed in' do
      it "returns http 302" do
        get :index
        expect(response).to have_http_status(302)
      end
    end

    context 'with signed in user' do
      before(:each) do
        login_with(user)
      end

      context 'with no subdomain' do
        it "returns http 302" do
          get :index
          expect(response).to have_http_status(302)
        end
      end

      context 'with subdomain' do
        context 'when user owns the site' do
          before(:each) do
            @request.host = "#{mock_subdomain}.example.com"
          end

          it 'returns http success' do
            get :index
            expect(response).to have_http_status(:success)
          end
        end

        context 'when user does not own the site' do
          let(:other_user) { create(:user) }
          before(:each) do
            login_with(other_user)
          end

          it 'returns http redirect' do
            get :index
            expect(response).to have_http_status(302)
          end
        end
      end
    end
  end

  describe "GET #show" do
    xit "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    xit "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    xit "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    xit "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
  end

  describe "GET #destroy" do
    xit "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
