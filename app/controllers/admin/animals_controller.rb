class AnimalsController < InheritedResources::Base
	before_filter :authenticate_admin_user!, :except => [:show, :index]
	
	respond_to :html
	actions :all	
end
