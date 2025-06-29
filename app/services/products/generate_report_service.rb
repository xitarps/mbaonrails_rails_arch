require 'csv'

class Products::GenerateReportService
  attr_reader :type, :errors, :data

  def initialize(**kwargs)
    @type = kwargs[:type]
    @errors = []
    @data
  end

  def call
    run
    self
  end

  def self.call(...)
    new(...).call
  end

  private

  def run
    begin
      @data = self.send(type)
    rescue
      errors << ['Error on type; Available types are: [csv]']
    end
  end

  def csv
    begin
      attributes = ProductsRepository.instance_attributes

      CSV.generate(headers: true) do |csv|
        csv << attributes

        ProductsRepository.all.each do |repository|
          csv << attributes.map{ |attr| repository.send(attr) }
        end
      end
    rescue StandardError => e
      errors << ['Error while generating CSV file']
    end
  end
end
