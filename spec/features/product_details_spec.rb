require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path
    
    first('.product').click_link('Details')
    # DEBUG
    
    # VERIFY
    expect(page).to have_css 'article.product-detail',count:1
    expect(page).to have_css("img[src*='apparel1.jpg']")
    save_screenshot
    puts page.html
  end
end
