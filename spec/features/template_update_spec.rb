require 'rails_helper'
require './spec/shared_contexts/site_setup.rb'

RSpec.feature "Template Update", type: :feature do
  # template ids available:
  # => hero_template
  # => second_section
  include_context "site setup"

  def set_host(host)
    default_url_options[:host] = host
    Capybara.app_host = "http://" + host
  end

  before(:each) do
    set_host("#{mock_subdomain}.lvh.me")
    login_as(user, scope: :user)
    visit '/admin/themes'
  end

  scenario "Admin User updates a template kind of file with" do
    template = theme.templates.first


    click_link(template.name)

    # we are now on the page - temporary we just want to know that
    # we are on the page
    expect(page).to have_css('#template-edit')
    template_string = "<div class='secondary-hero'></div>"

    within(:css, "form") do
      # fill_in('template_obj_name', with: 'secondary-hero')
      fill_in('main-editor', with: template_string)
      find("#template_obj_template", visible: false).set template_string
      click_button('Save')
    end

    expect(page).to have_css('#themes')
  end

  scenario "Admin User updates a stylesheets kind of file" do
    template = theme.stylesheets.first
    click_link(template.name)

    expect(page).to have_css('#template-edit')
    template_string = %{.hero-template{ position: absolute; }}

    within(:css, "form") do
      # fill_in('template_obj_name', with: 'secondary-hero')
      fill_in('main-editor', with: template_string)
      find("#template_obj_template", visible: false).set template_string
      click_button('Save')
    end
    expect(page).to have_css('#themes')
  end

  scenario 'Admin user updates a javascripts kind of file' do
    template = theme.javascripts.first
    click_link(template.name)

    expect(page).to have_css('#template-edit')

    template_string = %{ console.log('awesome'); }

    within(:css, "form") do
      # fill_in('template_obj_name', with: 'secondary-hero')
      fill_in('main-editor', with: template_string)
      find("#template_obj_template", visible: false).set template_string
      click_button('Save')
    end
    expect(page).to have_css('#themes')
  end

  scenario 'Admin user updates a settings kind of file with valid json' do
    click_link(theme.settings.name)
    expect(page).to have_css('#template-edit')

    template_string = %{{"neat":"cool"}}
    within(:css, "form") do
      # fill_in('template_obj_name', with: 'secondary-hero')
      fill_in('main-editor', with: template_string)
      find("#template_obj_template", visible: false).set template_string
      click_button('Save')
    end
    expect(page).to have_css('#themes')
  end

  scenario 'Admin user updates a setting kind of file with invalid json' do
    click_link(theme.settings.name)
    expect(page).to have_css('#template-edit')

    template_string = %{{"neat": cool}}
    within(:css, "form") do
      # fill_in('template_obj_name', with: 'secondary-hero')
      fill_in('main-editor', with: template_string)
      find("#template_obj_template", visible: false).set template_string
      click_button('Save')
    end
    expect(page).to have_css('#template-edit')
  end
end
