module Types
  ThemeType = GraphQL::ObjectType.define do
    name "theme"
    description "a theme"

    field :key, !types.Int, property: :id
    field :name, !types.String
    field :default, !types.Boolean
    field :kind, !types.String
    field :active, !types.Boolean
    field :site_id, !types.Int
    field :templates, types[TemplateObjType] do
      resolve -> (obj, args, ctx) {
        obj.templates + obj.javascripts + obj.stylesheets
      }
    end

    field :site, SiteType do
      resolve -> (obj, args, ctx) { obj.site }
      # resolve(obj, args, ctx) -> { obj.site }
    end
  end
end
