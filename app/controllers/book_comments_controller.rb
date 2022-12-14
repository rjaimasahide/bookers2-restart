class BookCommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]


  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = BookComment.find(params[:id])
    @comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:user_id, :book_id, :comment)
  end

  def correct_user
    @comment = BookComment.find(params[:id])
    unless @comment.user_id == current_user.id
           redirect_to books_path
    end
  end

end
