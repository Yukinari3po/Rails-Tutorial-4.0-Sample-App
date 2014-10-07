require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do

    it "shoud have the content 'Sample App'" do
	visit '/static_pages/home'
	expect(page).to have_content('Sample App')
    end
  end

  describe "Help Page" do

    it "should have the content 'Help'" do
	visit '/static_pages/home'
        expect(page).to have_content('help')
    end
  end
end
