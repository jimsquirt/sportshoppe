class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def public_users
    @users = User.search(params[:search])
  end

  def show
  	@user = User.find(params[:id])
    @products = Product.where(:user_id => @user.id)
    @message = Message.new
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      msg = "deleted na, pagcriminal case na"
    else
      msg = "di mada bai"
    end
    if current_user.admin
      redirect_to admin_users_path, :notice => msg
    else
      redirect_to users_public_users_path, :notice => msg
    end
  end


  def edit
        @user = User.find(params[:id])
    end
    
  def update
      @user = User.find(params[:id])
      if(@user.update_attributes(params[:user]))
          redirect_to user_path(@user), :notice => "Your account has been updated"
      else
          render "edit"
      end
  end

  def new
  	@user = User.new	
  end

  def create
	@user = User.new(params[:user])
	if @user.save
		redirect_to new_session_path, :notice => "Signed up!"
	else
		render "new"
	end
  end
end
