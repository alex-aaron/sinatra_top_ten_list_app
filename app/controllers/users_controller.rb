class UsersController < ApplicationController

    get '/login' do
        if !logged_in?
            redirect to '/lists'
        else
            erb :'users/login'
        end
    end
    
    get '/signup' do
        if !logged_in?
            redirect to '/lists'
        else
            erb :'users/create_user'
        end
    end

    get '/logout' do
        redirect to '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        session[:user_id] = @user.id
        redirect to '/lists'
    end

    post '/signup' do
    end

end