require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    a = [*('A'..'Z')].flatten
    @letters = Array.new(10) { a.sample }.join(', ')
  end

  def score
    params[:word].upcase.split('').each do |letter|
      included = params[:letters].split(', ').include?(letter)
      return @answer = "Sorry but #{params[:word].upcase} can't be built out of #{params[:letters]}" if included == false
    end
    api = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    results = JSON.parse(api)
    if results['found']
      @answer = "Congratulations! #{params[:word].upcase} is a valid English word!"
    else
      @answer = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    end
  end
end
