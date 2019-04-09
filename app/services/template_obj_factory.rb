# should this really be a concern
module TemplateObjFactory
  require 'active_support/concern'
  extend ActiveSupport::Concern

  included do
    # {
    #   "template_string"=>"<div class='secondary-hero'></div>",
    #   "template"=>"<div class='secondary-hero'></div>",
    #   "name"=>"secondary-hero"
    # }
    def insert_template(attributes = {})
      templ = create_template(attributes)
      fs = theme_files[templ.kind]
      if fs[templ.id].present?
        errors.add(:theme_files, :duplicate_key, message: 'name can\'t be a duplicated')
        return false
      else
        fs[templ.id] = {
          "name" => templ.name,
          "template" => templ.template,
          "kind" => templ.kind
        }
        temp_data = theme_files
        temp_data[templ.kind] = fs

        theme_files = temp_data
        return true
      end
    end

    def update_template(attributes = {})
      if attributes["id"] == 'settings'
        begin
          new_template = JSON.parse(attributes["template"])
          self.settings_data = new_template
          return true
        rescue JSON::ParserError
          errors.add(:theme_files, :invalid_json, message: 'validate your json first')
          return false
        end
      else
        templ = create_template(attributes)
        fs = self.theme_files[templ.kind]
        if fs[templ.id].present?
          fs[templ.id] = {
            "name" => templ.name,
            "template" => templ.template,
            "kind" => templ.kind
          }
          temp_data = self.theme_files
          temp_data[templ.kind] = fs

          self.theme_files = temp_data
          return true
        else
          errors.add(:theme_files, :missing_key, message: 'name can\'t be missing')
          return false
        end
      end
    end

    # initializes empty template
    def create_template(attributes = {})
      attributes["id"] = attributes["name"].split('.')[0] if attributes["name"].present?
      attributes["model_fk_name"] = "#{self.class.name.downcase}_id"
      attributes["model_fk_id"] = id
      TemplateObj.new(attributes)
    end

    # this is poorly named - this is retrieving templates
    def hydrate_template(factory_name, settings = {})
      key = settings["id"]
      defaults = {
        "id" => key,
        "model_fk_name" => "#{self.class.name.downcase}_id",
        "model_fk_id" => id,
        "kind" => factory_name,
        "settings" => settings_data,
      }
      h = theme_files[factory_name][key]

      defaults = defaults.merge(theme_files[factory_name][key]) if h
      TemplateObj.new(defaults)
    end

    # Also poorly named also retrieving templates
    # sorts alphabetically unless an array of template names
    # is passed in. In that case it will be custom sorted in that
    # order
    def hydrate_templates(factory_name, order = [])
      output = []
      s_keys = theme_files[factory_name] && theme_files[factory_name].keys if theme_files.present?
      return [] unless s_keys.present?
      # set s_keys to the intersection of order and s_keys if order is present
      if order.present? && order.is_a?(Array)
        s_keys = order & s_keys
      else
        s_keys = s_keys.sort
      end

      s_keys.each do |key|
        output << hydrate_template(factory_name, { "id" => key })
      end
      output
    end

    def javascripts
      @javascripts ||= hydrate_templates('javascripts')
    end

    def stylesheets
      @stylesheets ||= hydrate_templates('stylesheets')
    end

    def templates(order = nil)
      @templates ||= hydrate_templates('templates', order)
    end

    def current_template(options = {})
      @current_template ||= hydrate_current_template(options)
    end

    def section_list
      @section_list ||= self.class.find_node(settings_data, "content_for_index")
    end

    def sections
      @sections ||= self.class.find_node(settings_data, "sections")
    end

    def settings
      @settings ||= TemplateObj.new(
        {
          'id'=> 'settings',
          'name' => 'settings.json',
          "model_fk_name" => "#{self.class.name.downcase}_id",
          "model_fk_id" => id,
          'template' => settings_data.to_json,
          'kind' => 'json',
          'settings' => settings_data
        }
      )
    end
  end

  private
    def hydrate_current_template(options = {})
      case options[:kind]
      when 'templates'
        template = templates.find { |x| x.id == options[:template_id]}
      when 'stylesheets'
        template = stylesheets.find { |x| x.id == options[:template_id]}
      when 'javascripts'
        template = javascripts.find { |x| x.id == options[:template_id]}
      when 'json'
        settings
      else
        template = templates.first
      end
    end
end
