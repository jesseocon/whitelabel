module Types
  SiteType = GraphQL::ObjectType.define do
    name "Site"
    description "A Site"

    field :key, !types.Int, property: :id
    field :name, !types.String
    field :slug, !types.String
    field :activeTheme, ThemeType do
      resolve -> (obj, args, ctx) {
        obj.themes.find_by(active: true)
      }
    end
  end
end
