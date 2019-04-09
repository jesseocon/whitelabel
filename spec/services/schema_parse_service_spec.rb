require 'rails_helper'

describe 'SchemaParseService' do
  describe 'when not valid json' do
    it 'should return an empty ruby hash' do
      str = "{% schema %} this is the schema {% endschema %}"
      expect(SchemaParseService.parse(str)).to eq({})
    end
  end

  describe 'when nil' do
    it 'should return an empty ruby hash' do
      str = "{% schema %}{% endschema %}"
      expect(SchemaParseService.parse(str)).to eq({})
    end
  end

  describe 'when valid json' do
    it 'should return a ruby has with the correct keys' do
      str = '{% schema %} {"name": "value"} {% endschema %}'
      expect(SchemaParseService.parse(str)).to eq({"name"=>"value"})
    end
  end

  describe 'when valid json but with whitespace around it' do
    it 'should return a ruby hash with the correct keys' do
      str = 'blah blah{% schema %}             {"name": "value"}         {% endschema %}'
      expect(SchemaParseService.parse(str)).to eq({"name"=>"value"})
    end
  end

  describe 'when parsing a complete template' do
    it 'should return a ruby hash with the correct keys' do
      expect(SchemaParseService.parse(TemplateSpecHelper.default_template)).to eq({"name"=> "value"})
    end
  end
end