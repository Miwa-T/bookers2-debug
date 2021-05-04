class SearchController < ApplicationController
  def search
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:how],params[:word])
    else
      @books = Book.looks(params[:how],params[:word])
    end

    how = params[:how]
    @word = params[:word]
    @users = User.looks(how, @word)
    @books = Book.looks(how, @word)
  end
end