require 'spec_helper'

describe "Country Pages" do
  let(:base_title) { "Eudora" }
  subject { page }

  describe "index" do
    let(:country) { FactoryGirl.create(:country) }
    before(:each) do
      visit countries_path
    end
				it { should have_title(("#{base_title} | All Countries")  ) }
		    it { should have_content('All Countries') }

	    describe "pagination" do

		    before(:all) { 31.times { FactoryGirl.create(:country) } }
		    after(:all)  { Country.delete_all }

		    it { should have_selector('div.pagination') } #not working, not sure why
		    it "should list each blog" do
		      Country.paginate(page: 1).each do |country|
		        expect(page).to have_selector('li', text: country.name)
		      end
		    end

    end # end pagination
	end #index
	
	describe "New Country Page" do
		let(:country) { FactoryGirl.create(:country) }
		describe "should block access with invalid HTTP auth" do
			before do			
				visit new_country_path
			end
			
			it { should_not have_title(("#{base_title} | Add Country")  ) }
			it { should_not have_content('Add Country') }
			#assert_equal 401, page.status_code
      specify { expect(page.status_code).to  eq 401 }
		end #should block access
		

		describe "should block access with invalid password" do
			before do	
				basic_auth('admin1', 'wrong')					
				visit new_country_path
			end
			
			it { should_not have_title(("#{base_title} | Add Country")  ) }
			it { should_not have_content('Add Country') }
			#assert_equal 401, page.status_code
      specify { expect(page.status_code).to  eq 401 }
		end #should block access


		describe "should block access with invalid user" do
			before do	
				basic_auth('me', 'ILcorporations1234!!')					
				visit new_country_path
			end
			
			it { should_not have_title(("#{base_title} | Add Country")  ) }
			it { should_not have_content('Add Country') }
			#assert_equal 401, page.status_code
      specify { expect(page.status_code).to  eq 401 }
		end #should block access


		describe "should visit new country page with valid password" do
			before do
				basic_auth('admin1', 'ILcorporations1234!!')			
				visit new_country_path
			end
			
			it { should have_title(("#{base_title} | Add Country")  ) }
			it { should have_content('Add Country') }
      specify { expect(page.status_code).to  eq 200 }
		end #visit new country page with valid password

		describe "creating a new country" do
			let (:submit) {"Submit Country"}			
			before do
				basic_auth('admin1', 'ILcorporations1234!!')
				visit new_country_path
			end
	
			describe "with blank information" do
				it "should not create a country" do
					expect {click_button submit }.not_to change(Country, :count)
				end
			end #with blank

			describe "after submission" do
        before { click_button submit }

        it { should have_title('Add Country') }
        it { should have_content('error') }
      end #end after submission



			describe "with valid information" do
				before do
					fill_in "Name", 				with: "United States"

				end 
				it "should create a country" do
					expect {click_button submit}.to change(Country, :count).by(1)
				end

				 describe "after saving the country" do
		      before { click_button submit }
		      let(:country) { Country.find_by(name: "United States") }
					it { should have_content(country.name) }
					it { should have_link('Edit') }
					it { should have_link('Back') }
		      it { should have_title(country.name) }
		      it { should have_selector('div.alert.alert-success', text: 'New Country') }
		    end #end after saving the country	
			end #with valid information

		end#end creating a new country

	end #new blog page
	
	##########################

	describe "edit country page" do
    let(:country) { FactoryGirl.create(:country) }
    before do
			basic_auth('admin1', 'ILcorporations1234!!')
      visit edit_country_path(country)
    end

    describe "page" do
      it { should have_content("Edit Country") }
      it { should have_title("Edit Country") }

    end #end page

    describe "with invalid information" do
      let(:new_name)  { " " }
			before do

        fill_in "Name",             with: new_name
        click_button "Save changes"
      end

      it { should have_content('error') }
    end #end with invalid info

		describe "with valid information" do
      let(:new_name)  { "United States2" }

      before do
        fill_in "Name",             with: new_name

        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(country.reload.name).to  eq new_name }
 
    end #end edit with valid info

  end #end edit page

##########################3


end # end Blog pages
