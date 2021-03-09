require 'rails_helper'
require_relative 'images'

RSpec.feature "User can login", type: :feature, js: true do
  
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

    @user = User.create! name: 'Dan', email: "banana@yahoo.gov", password: '12345', password_confirmation: '12345'
  end
  
  scenario "and is redirected to the home page on successful login" do
  visit root_path

  find_link('Login').click()
  expect(find('main.container > h1')).to have_content "Login"
  fill_in "email", with: "banana@yahoo.gov"
  fill_in "password", with: "12345"
  find_button('Submit').click
  expect(page).to have_css 'article.product', count: 10
  expect(page).to have_content 'Signed in as Dan'
  
  end
end