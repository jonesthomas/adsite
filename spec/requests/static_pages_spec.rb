require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Eudora'" do
      visit '/static_pages/home'
      expect(page).to have_content('Eudora')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Eudora | Home")
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Eudora | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("Eudora | About Us")
    end
  end #end about page

 	describe "Contact page" do

    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title("Eudora | Contact")
    end
  end #end contact page


end
