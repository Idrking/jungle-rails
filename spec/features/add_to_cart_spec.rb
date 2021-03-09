require 'rails_helper'
require_relative 'images'

RSpec.feature "Visitor adds item to cart", type: :feature, js: true do
  
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99,
        image: open_asset('apparel1.jpg')
      )
    end
  end
  
  scenario "And the count on the cart displays the correct number" do
  visit root_path

  first('article.product').find_button('Add').click()
  
  save_screenshot
  expect(find_link('My Cart')).to have_content 'My Cart (1)'

  end
end
