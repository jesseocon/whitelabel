class Schema < Liquid::Block
  def initialize(tag_name)
    super
  end

  def render(context)
  end
end

Liquid::Template.register_tag('schema', Schema)