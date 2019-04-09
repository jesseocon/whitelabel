Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :currentTheme, Types::ThemeType do
    description "The active theme for the user"
    resolve -> (obj, args, ctx) { Theme.last }
  end

  field :currentSite, Types::SiteType do
    description "A site"
    argument :slug, types.String
    # resolve -> (obj, args, ctx) { Site.last }
    resolve -> (obj, args, ctx) {
      ctx[:current_user].sites.find_by(slug: args[:slug])
    }
    # resolve -> (obj, args, ctx) { Theme.last }
  end
end
