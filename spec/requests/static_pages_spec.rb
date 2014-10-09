require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do
 
    it "shoud have the h1 'Sample App'" do
      visit root_path
      expect(page).to have_content("Sample App")
    end

    it "shoud have the base title" do
    	visit root_path
    	expect(page).to have_title("#{base_title}")
      #""で括らないときちんと#でescapeされない
    end

    it "should not have a custom page title" do
      visit root_path
      expect(page).not_to have_title("| Home")
    end
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit help_path
      expect(page).to have_content("Help")
    end

    it "should have the title 'Help'" do
      visit help_path
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About Us'" do 
      visit about_path
      expect(page).to have_content("About Us")
    end

    it "should have the title 'About Us'" do
      visit about_path
      expect(page).to have_title("#{base_title} | About Us")
    end
  end

  describe "Contact Page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      expect(page).to have_content("Contact")
    end

    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("#{base_title} | Contact")
    end
  end

end
