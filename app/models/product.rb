class Product < ApplicationRecord
  include Searchable

  validates :name, presence: true
  validates :price, presence: true
end
