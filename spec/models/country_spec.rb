require 'spec_helper'

describe Country do

  before { @country = Country.new(name: "United States") }

  subject { @country }

  it { should respond_to(:name) }
  describe "when name is not present" do
    before { @country.name = " " }
    it { should_not be_valid }
  end # end name present
  
	describe "when name is too long" do
    before { @country.name = "a" * 71 }
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
end # end country
