class Category < ApplicationRecord
  validates_presence_of :title, :created_by
  has_many :recipes, dependent: :destroy
end
