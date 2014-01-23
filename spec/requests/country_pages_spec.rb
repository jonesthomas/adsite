require 'spec_helper'

describe "Country pages" do

  subject { page }

  describe "country page" do
    let(:country) { FactoryGirl.create(:country) }
    before { visit country_path(country) }

    it { should have_content(country.name) }
    it { should have_title(country.name) }

  end # end country page
#####################3
  describe "new country page" do
    before { visit new_country_path }

    it { should have_content('Add Country') }
    it { should have_title(full_title('Add Country')) }
  end

#############3
  describe "new country page" do

    before { visit new_country_path }

    let(:submit) { "Add new country" }

    describe "with invalid information" do
      it "should not create a country" do
        expect { click_button submit }.not_to change(Country, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "United States"

      end

      it "should create a country" do
        expect { click_button submit }.to change(Country, :count).by(1)
      end
    end
  end

#############33
end# end country
