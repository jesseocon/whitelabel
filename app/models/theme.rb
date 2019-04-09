class Theme < ApplicationRecord
  include FindNode
  include TemplateObjFactory
  belongs_to :site

  # can the enum be moved into the active_support/concern
  enum kind: { personal_theme: 0, public_theme: 1 }
end
