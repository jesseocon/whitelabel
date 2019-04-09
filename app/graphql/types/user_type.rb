module Types
  UserType = GraphQL::ObjectType.define do
    name "User"
    description "The user model"

    field :id, !types.Int
    field :email, !types.String
  end
end
