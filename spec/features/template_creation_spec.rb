require 'rails_helper'
require './spec/shared_contexts/site_setup.rb'

RSpec.feature "Template Creation", type: :feature do
  include_context "site setup"

  def set_host(host)
    default_url_options[:host] = host
    Capybara.app_host = "http://" + host
  end

  before(:each) do
    set_host("#{mock_subdomain}.lvh.me")
    login_as(user, scope: :user)
  end

  scenario "Admin User creates a template" do
    visit '/admin/themes'

    click_link('new-template-link')
    div_string = "<div class='secondary-hero'></div>"

    within(:css, "form") do
      fill_in('template_obj_name', with: 'secondary-hero')
      fill_in('main-editor', with: div_string)
      find("#template_obj_template", visible: false).set div_string
      click_button('Save')
    end

    expect(page).to have_css('#themes')
  end
end
