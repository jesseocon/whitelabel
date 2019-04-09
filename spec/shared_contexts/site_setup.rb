RSpec.shared_context "site setup", shared_context: :metadata do
  let(:default_user) { create :user }
  let(:default_site) { default_user.sites.create(name: 'default site')}
  let(:default_theme) {
    Theme.create(
      settings_data: ThemeSpecHelper.default_settings,
      name: 'Debut',
      default: true,
      theme_files: TemplateSpecHelper.theme_files,
      kind: 'public_theme',
      active: false,
      site_id: default_site.id
    )
  }

  let(:user) { create(:user) }
  let(:mock_subdomain) { 'testing-123'}
  let(:site) { user.sites.create(name: 'testing 123') }
  let(:theme) { Theme.create({
      settings_data: ThemeSpecHelper.default_settings,
      name: 'Debut',
      default: false,
      theme_files: TemplateSpecHelper.theme_files,
      kind: 'personal_theme',
      active: true,
      site_id: site.id
    })
  }
  before(:each) do
    user
    site
    theme
    default_theme
  end
end
