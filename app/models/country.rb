class Country < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 70 }, uniqueness: { case_sensitive: false }
  validates :country_code, presence:true, uniqueness: true
	#def to_param
		#"#{id} #{name}".parameterize
	#end
	extend FriendlyId
 friendly_id :name, use: [:slugged, :history]
	#def should_generate_new_friendly_id?
		#new_record?
	#end
  default_scope -> { order('created_at ASC') }
	def should_generate_new_friendly_id?
  	slug.blank? || name_changed?
	end
end
