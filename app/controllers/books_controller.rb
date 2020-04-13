class BooksController < ApplicationController

	before_action :ensure, {only: [:edit, :update, :destroy]}

	def new
		@book = Book.new
	end
	def create
		@post_book = Book.new(book_params)
		@post_book.user_id = current_user.id
		if @post_book.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@post_book)
		else
			@books = Book.all
			@user = User.find(current_user.id)
			render :index
		end
	end
	def index
		@books = Book.all
		@user = User.find(current_user.id)
		@post_book = Book.new
	end
	def show
		@book = Book.find(params[:id])
		@user = User.find(@book.user_id)
		@post_book = Book.new
	end
	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end
	def edit
		@book = Book.find(params[:id])
	end
	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "You have updated book successfully."
			redirect_to book_path(@book)
		else
			render :edit
		end
	end
	def ensure
		if current_user.id != Book.find(params[:id]).user_id
			redirect_to books_path
		end
	end
	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
