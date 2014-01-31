require 'spec_helper'

describe Country do

  before { @country = Country.new(name: "United States", country_code: 840) }

  subject { @country }

  it { should respond_to(:name) }
  it { should respond_to(:country_code) }
	it {should be_valid}

  describe "when name is not present" do
    before do
			@country.name = " " 
			@country.country_code = 840
		end
    it { should_not be_valid }
  end # end name present
  
	describe "when name is too long" do
    before do
			@country.name = "a" * 71 
			@country.country_code = 840
		end
    it { should_not be_valid }
  end# end name too long
  
	describe "when country name is already taken" do
    before do
      country_with_same_name = @country.dup
      country_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when country name is already taken case sensitive" do
    before do
      country_with_same_name = @country.dup
      country_with_same_name.name = @country.name.upcase
      country_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when country code is already taken" do
    before do
      country_with_same_number = @country.dup
      country_with_same_number.save
    end

    it { should_not be_valid }
  end

end # end country
