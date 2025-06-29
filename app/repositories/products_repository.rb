class ProductsRepository
  attr_accessor :product

  def initialize(attributes = nil)
    @product = Product.new(attributes) if attributes
    self
  end

  def save
    @product.save
  end

  def self.all
    Product.all.map do |product|
      repository = self.new
      repository.product = product
      repository
    end
  end

  def self.find(id)
    repository = self.new
    repository.product = Product.find(id)
    repository
  end

  def self.search(term)
    Product.search(term).map do |product_hash|
      repository = self.new
      temporary_product = Product.new(product_hash)
      temporary_product.instance_variable_set(:@new_record, false)
      repository.product = temporary_product

      repository
    end
  end

  def update(attributes)
    @product.update(attributes)
  end

  def destroy
    @product.destroy
  end

  def price
    @product.price
  end

  def name
    @product.name
  end

  def errors
    @product.errors
  end
end