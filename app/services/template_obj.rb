class TemplateObj
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include FindNode
  attr_accessor :id, :name, :template, :settings, :template_string, :kind

  def initialize(attributes = {})
    @id              = attributes["id"]
    @model_fk_name   = attributes["model_fk_name"]
    @model_fk_id     = attributes["model_fk_id"]
    @name            = attributes["name"]
    @template_string = attributes["template"]
    @kind            = attributes["kind"]
    @settings        = attributes["settings"]
    self.class.send(:attr_accessor, attributes["model_fk_name"]) if attributes["model_fk_name"]
    instance_variable_set("@#{attributes["model_fk_name"]}", attributes["model_fk_id"]) if attributes["model_fk_name"]
  end

  def persisted?
    false
  end

  def template
    @template ||= hydrate_template
  end

  def hydrate_template
    templ = Liquid::Template.parse(template_string) if template_string.present?
    return '' unless templ
    drop = SettsDrop.new(settings_hash)
    templ = templ.render('settings' => drop)
    templ
  end

  def settings_hash
    sections = self.class.find_node(settings, "sections")
    return {} unless sections
    section = sections[id]
    return {} unless section
    section["settings"] || {}
  end
end
