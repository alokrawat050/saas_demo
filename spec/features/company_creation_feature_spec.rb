require 'rails_helper'

describe 'company creation' do
    it 'allows user to create company' do
        visit root_path
        click_link 'Create Account'
        
        fill_in 'Name', with: 'Alok'
        fill_in 'Email', with: 'alokrawat050@gmail.com'
        fill_in 'Password', with: 'pw'
        fill_in 'Password Confirmation', with: 'pw'
        fill_in 'Company_name', with: 'onetaxgst'
        click_buton 'Create Account'
        
        expect(page).to have_content('Signed up succssfully')
    end
end