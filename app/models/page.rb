class Page < ActiveRecord::Base
	has_ancestry
	validates :slug, :name, uniqueness: true, presence: true
	before_validation :generate_slug
	
	def to_param
		slug
	end
	
	def generate_slug
		self.slug = Russian.translit(name).parameterize
	end
end
