class WordsController < ApplicationController
  def index
    # render json: Word.search_word(params[:term])
    render json: Word.search_word_index(params[:term]).limit(5).pluck(:word)

    # render json: Word.all.pluck(:word)

  end
end
