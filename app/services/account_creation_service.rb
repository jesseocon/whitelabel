class AccountCreationService
  # Active model plumbing
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  ATTRIBUTES = [:name, :user]
  attr_accessor *ATTRIBUTES

  def persisted?
    false
  end

  def initialize(attributes = {}, user)
    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
    end
    @user = user
  end

  validate do
    [site, site_theme].each do |object|
      unless object.valid?
        object.errors.each do |key, values|
          errors.add(key, values)
        end
      end
    end
  end

  def site
    @site ||= Site.new(name: self.name, user: user)
  end

  def theme
    @theme ||= Theme.find_by(default: true)
  end

  def site_theme
    @site_theme ||= site.themes.new(
      settings_data: theme.settings_data,
      name: "#{theme.name}-#{site.name}",
      default: false,
      theme_files: theme.theme_files,
      kind: 'personal_theme',
      active: true,
    )
  end

  def save
    return false unless valid?
    if create_objects
      return true
    else
      return false
    end
  end

  private
    def create_objects
      ActiveRecord::Base.transaction do
        site.save!
        site_theme.save!
      end
      return true
    rescue
      false
    end
end
