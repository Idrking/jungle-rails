require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    before do
      @category = Category.new(name: "test")
    end
 
    it "should validate correct with all fields set" do
      @product = Product.new(
        name: "test_product",
        description: "this is a test",
        category: @category,
        quantity: 4,
        image: "https://yahoo.gov",
        price: 400,
      )

      @product.save
      expect(@product.errors).to be_empty
    end

    it "should produce the error - Name can't be blank - when given a nil name" do
      @product = Product.new(
        name: nil,
        description: "this is a test",
        category: @category,
        quantity: 4,
        image: "https://yahoo.gov",
        price: 400,
      )

      @product.save
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
      expect(@product.errors.full_messages.length).to be 1
    end

    it "should produce the error - Price cents is not a number - when given a nil price" do
      @product = Product.new(
        name: "test",
        description: "this is a test",
        category: @category,
        quantity: 4,
        image: "https://yahoo.gov",
        price: nil,
      )

      @product.save
      expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end

    it "should produce the error - Quantity can't be blank - when given a nil quanity" do
      @product = Product.new(
        name: "test",
        description: "this is a test",
        category: @category,
        quantity: nil,
        image: "https://yahoo.gov",
        price: 300,
      )

      @product.save
      expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
    end

    it "should produce the error - Category can't be blank - when given a nil category" do
      @product = Product.new(
        name: "test",
        description: "this is a test",
        category: nil,
        quantity: 2,
        image: "https://yahoo.gov",
        price: 300,
      )

      @product.save
      expect(@product.errors.full_messages).to eq(["Category can't be blank"])
    end

  end
end
