require 'rails_helper'
require_relative 'images'

RSpec.feature "Visitor navigates to product detail page", type: :feature, js: true do
  
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
  
  scenario "From the home page" do
  visit root_path

  first('article.product').find_link('Details').click()
  
  expect(page).to have_css 'article.product-detail'

  end
end
