class UsersController < ApplicationController

  before_action :ensure, {only: [:edit, :update]}

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
    @post_book = Book.new
  end
  def index
    @users = User.all
    @user = User.find(current_user.id)
    @post_book = Book.new
  end
  def edit
  	@user = User.find(params[:id])
  end
  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    	redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def ensure
    if current_user.id != User.find(params[:id]).id
      redirect_to user_path(current_user.id)
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
