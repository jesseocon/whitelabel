require 'rails_helper'

describe 'TemplateObjFactory' do
  let(:theme) {
    Theme.create(
      settings_data: ThemeSpecHelper.default_settings,
      name: 'Debut',
      default: true,
      theme_files: TemplateSpecHelper.theme_files,
      kind: 'public_theme',
      active: false
    )
  }

  describe '#update_template' do
    context 'a settings json file' do
      it 'should update the theme.settings_data' do
        settings_template = { "neat" => "cool" }.to_json
        update_hash = {
          "id" => 'settings',
          "template" => settings_template
        }

        resp = theme.update_template(update_hash)
        expect(resp).to be(true)
        expect(theme.settings_data).to eq(JSON.parse(settings_template))
      end
    end

    context 'a css, javascript or html template' do
      describe 'when the key being inserted exists' do
        it 'should update the key' do
          update_hash = {
            "id" => "hero_template",
            "kind" => "templates",
            "template" => %{
              <div class='new-template'></div>
            }
          }
          resp = theme.update_template(update_hash)
          expect(resp).to be(true)
          expect(theme.theme_files["templates"]["hero_template"]["template"]).to eq(update_hash["template"])
        end
      end

      describe 'when the key being inserted doesnt exist' do
        it 'should not update the key' do
          update_hash = {
            "id" => 'non_existent_id',
            "kind" => 'templates',
            "template" => %{
              <div class='missing-template'></div>
            }
          }
          resp = theme.update_template(update_hash)
          expect(resp).to be(false)
        end
      end
    end
  end

  describe '#insert_template' do
    describe 'when the key being inserted is unique' do
      it 'should update the theme_files' do
        theme.insert_template(
          {
            "template_string"=>"<div class='secondary-hero'></div>",
            "template"=>"<div class='secondary-hero'></div>",
            "name"=>"secondary-hero.html.liquid",
            "kind"=> "templates"
          }
        )
        expect(theme.theme_files["templates"]["secondary-hero"]).to_not be_nil
        expect(theme.theme_files["templates"]["secondary-hero"]["name"]).to eq("secondary-hero.html.liquid")
      end
    end

    describe 'when the key is not unique' do
      it 'should not insert the template' do
        resp = theme.insert_template(
          {
            "template_string"=>"<div class='secondary-hero'></div>",
            "template"=>"<div class='secondary-hero'></div>",
            "name"=>"hero_template.liquid",
            "kind"=> "templates"
          }
        )
        expect(resp).to eq(false)
        expect(theme.valid?).to eq(false)
      end
    end
  end

  describe '#create_template' do
    it 'should set the right variables' do
      template = theme.create_template(
        {
          "template_string"=>"<div class='secondary-hero'></div>",
          "template"=>"<div class='secondary-hero'></div>",
          "name"=>"secondary-hero.html.liquid",
          "kind"=> "templates"
        }
      )
      expect(template.id).to eq('secondary-hero')
      expect(template.kind).to eq('templates')
      expect(template.theme_id).to eq(theme.id)
    end
  end

  describe '#hydrate_template' do
    it 'should create a hydrated object' do
      template = theme.hydrate_template('templates')
      expect(template.kind).to eq('templates')
      expect(template).to respond_to(:theme_id)
    end
  end

  describe '#create_templates' do
    describe 'with single object' do
      it 'should output a single object' do
        theme_files = { "templates" => { "hero_template" => { "name" => 'neat', "template" => 'neat' }}}
        theme.theme_files = theme_files
        temp_obj = TemplateObj.new(
          {
            "id" => "hero_template",
            "name" => 'neat',
            "template" => 'neat',
            "settings" => ThemeSpecHelper.default_settings
          }
        )
        expect(theme.templates[0].name).to eq(temp_obj.name)
        expect(theme.templates[0].id).to eq(temp_obj.id)
        expect(theme.templates[0].template).to eq(temp_obj.template)
        expect(theme.templates[0].theme_id).to eq(theme.id)
        expect(theme.templates[0].kind).to eq('templates')
      end
    end

    describe 'with multiple objects' do
      let(:tf) {
        {
          "templates" => {
            "hero_template" => { "name" => 'neat', "template" => 'neat' },
            "second_section" => { "name" => 'cool', "template" => 'cool' },
            "third_section" => { "name" => 'third name', "template" => 'third template' }
          }
        }
      }

      describe 'with default sort order' do
        describe 'templates' do
          it 'should output an array of templ_objs sorted alphabetically' do
            theme.theme_files = tf
            expect(theme.templates[0].name).to eq('neat')
            expect(theme.templates[1].name).to eq('cool')
          end
        end

        describe 'javascripts with no javascripts keys' do
          it 'should output an empty array' do
            theme.theme_files = tf
            expected_obj = []
            expect(theme.javascripts).to eq(expected_obj)
          end
        end
      end

      describe 'when sort order is passed in' do
        it 'should output array of templ_objs in order of array' do
          theme.theme_files = tf
          # theme.templates = TemplateObjFactory.create('templates', theme, ["second_section", "third_section", "hero_template"])
          templ1 = theme.templates(["second_section", "third_section", "hero_template"])[0]
          templ2 = theme.templates(["second_section", "third_section", "hero_template"])[1]
          templ3 = theme.templates(["second_section", "third_section", "hero_template"])[2]
          expect(templ1.name).to eq('cool')
          expect(templ2.name).to eq('third name')
          expect(templ3.name).to eq('neat')
        end
      end
    end
  end
end
