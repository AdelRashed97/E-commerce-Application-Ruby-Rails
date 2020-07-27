require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:all) do
     Category.destroy_all
     Category.create( name: 'Apparel')
    end

    context "Given all parameters" do
      it "saves" do
        product = Product.create(name:'name',description:'description',image:"image",quantity: 1,price: 5,category_id:1)
        expect(product.errors.messages).to be {}

      end
    end

    context "Missing a product name " do
      it "give an error" do
        product = Product.create(description:'description',image:"image",quantity: 1,price: 5,category_id:1)
        expect(product.errors[:name]).not_to be_empty

       end

    end

    context "Missing a product price" do
      it "give an error" do
        product = Product.create(name:'name',description:'description',image:"image",quantity: 1,category_id:1)
        expect(product.errors[:price]).not_to be_empty

       end

    end

    context "Missing a product quantity" do
      it "give an error" do
        product = Product.create(name:'name',description:'description',image:"image",price: 1,category_id:1)
        expect(product.errors[:quantity]).not_to be_empty

       end

    end

    context "Missing category" do
      it "give an error" do
        product = Product.create(name:'name',description:'description',image:"image",quantity: 1,price: 5)
         expect(product.errors[:category]).not_to be_empty

       end

    end
  

  end
end
