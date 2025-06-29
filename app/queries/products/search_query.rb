class Products::SearchQuery
  def initialize(**kwargs)
    @table_name = kwargs[:table_name]
    @fields = kwargs[:fields]
    @term = kwargs[:term]
    @query = ''
    @result = nil
  end

  def self.call(table_name: nil, fields: nil, term: nil)
    new(table_name:, fields:, term:).call
  end

  def call
    run
  end

  private

  attr_reader :table_name, :fields, :term
  attr_accessor :query, :result

  def run
    build_select
    build_from
    build_where

    execute_query
    convert_result_to_hash

    result
  end

  def build_select
    query << 'SELECT * '
  end

  def build_from
    query << "FROM #{table_name} "
  end

  def build_where
    where_clause = 'WHERE '
    sql_fields = fields.map do |field|
      "#{field}::text ILIKE :term"
    end
    query << where_clause << sql_fields.join(' OR ')
  end

  def execute_query
    @result = ActiveRecord::Base.connection.execute(
      ApplicationRecord.sanitize_sql_array(
        [ query, term: "%#{term}%" ]
      )
    )
  end

  def convert_result_to_hash
    @result = JSON.parse(result.to_json, symbolize_names: true)
  end
end