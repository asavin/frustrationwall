class UsersController < ApplicationController
    def frustrations
        unless current_user.nil?
            @frustrations = current_user.frustrations
        end
        
        respond_to do |format|
            format.html #frustrations.html.erb
            format.json { render json: @frustrations }
        end
    end
end
