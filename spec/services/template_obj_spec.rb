require 'rails_helper'

describe 'TemplateObj' do
  let(:to) { TemplateObj.new(
      {
        "id"=> "hero",
        "name" => 'neat',
        "template" => 'neat {{ settings.title }}',
        "kind" => 'templates',
        "settings" => ThemeSpecHelper.default_settings
      }
    )
  }
  let(:ts) {
    TemplateObj.new
  }

  it 'should be a template object' do
    expect(ts.name).to eq(nil)
  end


  it 'should have the correct attributes' do
    expect(to.name).to eq('neat')
    expect(to.id).to eq('hero')
    expect(to.template).to eq('neat Hero Text')
    expect(to.template_string).to eq('neat {{ settings.title }}')
    expect(to.settings_hash["title"]).to eq('Hero Text')
    expect(to.kind).to eq('templates')
  end

  describe 'settings template object' do
    let(:to) {
      TemplateObj.new(
        {
          "id" => 'settings',
          "name" => 'settings.json',
          "template" => ThemeSpecHelper.default_settings.to_json,
          "kind" => 'json',
          "settings" => ThemeSpecHelper.default_settings
        }
      )
    }


    it 'should return the correct values' do
      expect(to.template).to eq(ThemeSpecHelper.default_settings.to_json)
    end
  end
end
