module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def search(term)
      fields = new.attributes.keys.excluding('id', 'created_at', 'updated_at')
      table_name = self.table_name
      Products::SearchQuery.call(table_name:, fields:, term:)
    end
  end
end