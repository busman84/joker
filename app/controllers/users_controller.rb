class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  	def new
  		@user = User.new
  	end

	def show
	
	end

	def create
    	@user = User.new(user_params)
    	if @user.save
     		redirect_to @user
   		else
      		render 'new'
    	end
  	end

end

private
  	def set_user
      @user = User.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :username, :email, :password, :first_name, :last_name)
    end
