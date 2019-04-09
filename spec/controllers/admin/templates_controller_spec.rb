require 'rails_helper'
require './spec/shared_contexts/site_setup.rb'

RSpec.describe Admin::TemplatesController, type: :controller do
  include_context "site setup"

  describe 'GET #new' do
    context 'without subdomain' do
      it 'should redirect' do
        get :new, params: { theme_id: theme.id }
        expect(response).to have_http_status(302)
        expect(assigns(:theme)).to eq(nil)
      end
    end

    context 'with subdomain' do
      before(:each) do
        @request.host = "#{mock_subdomain}.example.com"
      end

      context 'with signed in user' do
        before(:each) do
          login_with(user)
        end

        it 'should return success' do
          get :new, params: { theme_id: theme.id, kind: 'templates' }
          templ = assigns(:template)
          expect(response).to have_http_status(:success)
          expect(assigns(:theme)).to eq(theme)
          expect(templ).to be_a(TemplateObj)
          expect(templ.theme_id).to eq(theme.id)
          expect(templ.settings).to be_nil
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:id) { "hero_template" }
    let(:kind) { "templates" }
    let(:template) { "<div></div>"}
    let(:update_params) { { "kind"=> kind, "id" => id, "template" => template } }
    let(:subject) { put :update, params: { theme_id: theme.id, template_obj: update_params, id: id } }

    context 'subdomain' do
      before(:each) do
        @request.host = "#{mock_subdomain}.example.com"
      end

      context 'signed in' do
        context 'owner' do
          context 'editing settings' do
            let(:id) { 'settings' }
            let(:kind) { 'json' }
            let(:template) {'{"neat":"cool"}'}
            it 'should have status success' do
              login_with(user)
              expect(subject).to redirect_to(admin_themes_path)
              theme.reload
              expect(theme.settings_data).to eq(JSON.parse(template))
            end
          end

          context 'template exists' do
            it 'should have success' do
              login_with(user)
              expect(subject).to redirect_to(admin_themes_path)
              theme.reload
              expect(theme.theme_files[kind][id]["template"]).to eq(template)
            end
          end

          context 'does not exist' do
            let(:id) { "heroooooos_template" }
            it 'should render the edit template' do
              login_with(user)
              expect(subject).to render_template(:edit)
            end
          end
        end

        context 'not owner' do
          it 'should redirect' do
            login_with(create :user)
            expect(subject).to have_http_status(302)
          end
        end
      end

      context 'signed out' do
        it 'should redirect to homepage' do
          expect(subject).to have_http_status(302)
        end
      end
    end

  end
  describe 'POST #create' do
    context 'subdomain'do
      before(:each) do
        @request.host = "#{mock_subdomain}.example.com"
      end

      context 'signed in user' do
        before(:each) do
          login_with(user)
        end

        context 'valid params' do
          it 'should save a template to theme_files of a given template' do
            template_obj = {
              kind: "templates",
              template: "<div class='supersauce'></div>",
              name: 'unique.liquid'
            }

            post :create, params: { theme_id: theme.id, template_obj: template_obj }
            expect(response).to redirect_to(admin_themes_path)
          end
        end

        context 'invalid params' do
          let(:template_obj) {
            {
              kind: "templates",
              template: "<div class='supersauce'></div>",
              name: 'second_section.liquid'
            }
          }

          subject { post :create, params: { theme_id: theme.id, template_obj: template_obj } }

          it 'should not redirect' do
            expect(subject).to render_template(:new)
            expect(assigns(:template).template_string).to eq(template_obj[:template])
          end
        end
      end
    end
  end
end
