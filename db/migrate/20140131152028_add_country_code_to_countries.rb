class AddCountryCodeToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :country_code, :integer
		add_index :countries,:country_code, unique: true
  end
end
