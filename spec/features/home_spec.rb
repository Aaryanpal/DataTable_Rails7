require 'rails_helper'

RSpec.describe 'Home Root' do
    it 'displays the name of the app' do
    visit('/')
    expect(page).to have_content('Products')
    end

    it 'displays the Table Heade' do
        click_link('Name')
        expect(current_path).to eql('/products?count=10&amp;direction=asc&amp;query=+&amp;sort=name')
        expect(page).to have_content('Name')
    end
end