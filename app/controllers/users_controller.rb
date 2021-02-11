class UsersController < ApplicationController

    get '/login' do
        if logged_in?
            redirect to '/lists'
        else
            erb :'users/login'
        end
    end
    
    get '/signup' do
        if logged_in?
            redirect to '/lists'
        else
            erb :'users/create_user'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
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
            redirect to '/signup'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to "/signup"
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
            redirect to '/lists'
        end
    end

end