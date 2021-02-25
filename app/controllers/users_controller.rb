require 'rack-flash'

class UsersController < ApplicationController
    use Rack::Flash
    get '/login' do
        if logged_in?
            flash[:notice] = "You are already logged in!"
            redirect to '/lists'
        else
            erb :'users/login'
        end
    end
    
    get '/signup' do
        if logged_in?
            flash[:notice] = "You are already logged in!"
            redirect to '/lists'
        else
            erb :'users/create_user'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            erb :'users/logout'
        else
            flash[:notice] = "You are not logged in or signed up."
            redirect to '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @lists = @user.lists.sort_by {|obj| obj.category}
        erb :'users/show'
    end

    post '/login' do
        if User.find_by(username: params[:username])
            @user = User.find_by(username: params[:username])
            session[:user_id] = @user.id
            redirect to '/lists'
        else
            flash[:notice] = "You do not have an account yet! Sign up here."
            redirect to '/signup'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            flash[:notice] = "You didn't fill out one or more of the fields."
            redirect to "/signup"
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            redirect to '/lists'
        end
    end

end