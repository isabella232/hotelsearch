class Hotel < ActiveRecord::Base

	def self.search(params)
		q = params[:q]
	  wildcard_search = "%#{q}%"
	  where("name LIKE :search OR address LIKE :search", search: wildcard_search)
	end

end
