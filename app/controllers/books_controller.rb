# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show]
  before_action :logged_in_user

  def new
    @places = Place.all
    @book = Book.new
  end

  def index
    @books = Book.order(:title).page params[:page]
  end

  def show; end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :image_url, :publish_date,
                                 :publisher, :page_count, :textship, :description, :place_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def logged_in_user
    if logged_in?
    else
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end
end
