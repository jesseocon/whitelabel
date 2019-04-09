class Site < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :themes
  validates :name, uniqueness: true
end
