require 'json'
require 'open-uri'

class GamesController < ApplicationController
  LETTERS = ('A'..'Z').to_a
  def new
    @letters = LETTERS.sample(10)
  end

  def score
    @word = params[:word].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    url_serialized = open(url).read
    check_word = JSON.parse(url_serialized)
    @check_word = check_word['found']
    @letters = params[:letters]
    @letters = @letters.split(' ')
    word_array = @word.chars
    if (word_array - @letters).empty? == false
      @results = "Sorry, but #{@word.upcase} can't be built out of the original grid"
    elsif (word_array - @letters).empty? && !@check_word
      @results = "Sorry, but #{@word.upcase} does not seem to be a valid English word"
    elsif (word_array - @letters).empty? && @check_word
      @results = "#{@word.upcase} is a valid English word!"
    end
  end
end
