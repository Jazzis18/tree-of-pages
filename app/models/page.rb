class Page < ActiveRecord::Base
	has_ancestry
	validates :slug, :name, uniqueness: true, presence: true
	before_validation :generate_slug
	
	def to_param
		slug
	end
	
	def generate_slug
		name_as_slug = Russian.translit(name).parameterize
		if parent.present?
		  self.slug = [parent.slug, (slug.blank? ? name_as_slug : slug.split('/').last)].join('/')
		else
		  self.slug = name_as_slug if slug.blank?
		end
	end
	
end
