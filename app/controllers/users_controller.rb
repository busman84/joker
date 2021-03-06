class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  	def new
  		@user = User.new
  	end

  	def index
    	@users = User.paginate(page: params[:page])
  	end

	def show
	
	end

	def create
    	@user = User.new(user_params)
    	if @user.save
    		log_in @user
     		redirect_to @user
   		else
      		render 'new'
    	end
  	end

  	def edit
    	@user = User.find(params[:id])
  	end

  	def update
    	@user = User.find(params[:id])
    	if @user.update_attributes(user_params)
      		# Handle a successful update.
      		redirect_to @user
    	else
      		render 'edit'
    	end
    end

    def destroy
    	User.find(params[:id]).destroy
    
    	redirect_to users_url
  	end

private
  	def set_user
      @user = User.find(params[:id])
    end

	# Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :username, :email, :password, :first_name, :last_name)
    end

     # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
      	store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end