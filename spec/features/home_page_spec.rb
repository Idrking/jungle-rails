require 'rails_helper'
require_relative 'images'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do
  
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
  
  scenario "They see all products" do
  visit root_path
  save_screenshot
  expect(page).to have_css 'article.product', count: 10
  end
end
