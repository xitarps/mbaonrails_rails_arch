module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def search(field, term)
      table = self.arel_table
      self.where(table[field].matches("%#{term}%"))
    end
  end
end