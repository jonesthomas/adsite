class Country < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 70 }, uniqueness: { case_sensitive: false }
end
