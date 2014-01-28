class Country < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 70 }, uniqueness: { case_sensitive: false }
	#def to_param
		#"#{id} #{name}".parameterize
	#end
	extend FriendlyId
 friendly_id :name, use: [:slugged, :history]
	#def should_generate_new_friendly_id?
		#new_record?
	#end
	def should_generate_new_friendly_id?
  	slug.blank? || name_changed?
	end
end
