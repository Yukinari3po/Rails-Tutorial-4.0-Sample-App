require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  subject { page }

  describe "Home page" {
    before{ visit root_path }
    it { should have_content("Sample App") }
    it { should have_title("#{base_title}") } #""で括らないときちんと#でescapeされない
    it { should_not have_title("| Home") }
    }
  describe "Help page" {
    before{ visit help_path }
    it { should have_content("Help") }
    it { should have_title("#{base_title} | Help") }
    }
  describe "About page" {
    before{ visit about_path }  
    it { should have_content("About Us") }
    it { should have_title("#{base_title} | About Us") }
    }
  describe "Contact Page" {
    before{ visit contact_path }
    it { should have_content("Contact") }
    it { should have_title("#{base_title} | Contact") }
  }