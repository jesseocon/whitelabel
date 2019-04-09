module Types
  TemplateObjType = GraphQL::ObjectType.define do
    name "TemplateObj"
    description "A Template Object"

    field :id, !types.String
    field :name, !types.String
    field :templateString, !types.String, property: :template_string
    field :kind, !types.String
  end
end
