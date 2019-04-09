require 'rails_helper'
require './spec/shared_contexts/site_setup.rb'

RSpec.feature "Account Creation", type: :feature do
  include_context 'site setup'

  def set_host(host)
    default_url_options[:host] = host
    Capybara.app_host = "http://" + host
  end

  scenario 'user creates an account with a fresh email' do
    set_host("awesome-123.lvh.me")
    visit '/admin/sign_up'
    password = 'password123'
    within(:css, "form") do
      fill_in('user_email', with: 'jesseocon+01@gmail.com')
      fill_in('user_password', with: password)
      fill_in('user_password_confirmation', with: password)
      click_button("Sign up")
    end
    expect(page).to have_css('#new-admin-account')


    within(:css, "form") do
      fill_in('account_name', with: 'awesome-123')
      click_button('Create account')
    end

    expect(page).to have_css('#themes')
  end

  scenario 'user creates an account with an email already in use' do
    set_host("awesome-123.lvh.me")
    visit '/admin/sign_up'
    password = 'password123'

    within(:css, "form") do
      fill_in('user_email', with: user.email)
      fill_in('user_password', with: password)
      fill_in('user_password_confirmation', with: password)
      click_button("Sign up")
    end
    expect(page).to have_css('#admin-sign-up')
  end

  scenario 'user creates an account with a site that is already in use' do
    set_host("testing-123.lvh.me")
    visit '/admin/sign_up'
    password = 'password123'
    within(:css, "form") do
      fill_in('user_email', with: 'jesseocon+01@gmail.com')
      fill_in('user_password', with: password)
      fill_in('user_password_confirmation', with: password)
      click_button("Sign up")
    end

    within(:css, "form") do
      fill_in('account_name', with: 'testing 123')
      click_button('Create account')
    end
    expect(page).to have_css('#new-admin-account')
  end
end
