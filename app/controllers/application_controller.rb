require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
    end

    def create_category_heading(category_slug)
      category_array = category_slug.split("_")
      category_array.map do |word|
        if word != "and"
          word.capitalize
        else
          word
        end
      end.join(" ")
    end
    
  end

end
