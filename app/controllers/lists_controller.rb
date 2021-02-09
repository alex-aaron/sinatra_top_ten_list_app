class ListsController < ApplicationController

    #CREATE
    get '/new' do
        erb :'lists/new'
    end
    #READ
    #Index
    get '/lists' do
        erb :'lists/lists'
    end

    #Show
    get '/lists/:category' do
        category = params[:category].gsub("-", "_")
        @lists = List.send(category)
        erb :'lists/show_category'
    end

    get '/lists/:id' do
        @list = List.find_by_id(params[:id])
        erb 'lists/show_list'
    end

    get '/lists/:id/edit' do
        @list = List.find_by_id(params[:id])
        if logged_in?
            if current_user == @list.user
                erb :'lists/edit'
            else
                redirect to "/lists/#{list.id}"
            end
        else
            redirect to '/login'
        end
    end

    post '/lists' do 
        if logged_in?
            if params[:content] == "" || params[:category] == "" || params[:title] == ""
                redirect to '/new'
                #add message
            else
                @user = current_user
                @list = List.create(title: params[:title], category: params[:category].to_sym, content: params[:content], user_id: @user.id)
                @user.lists << @list
                binding.pry
                redirect to "/lists/#{@list.id}"
            end
        else
            redirect to '/login'
        end
    end

    #UPDATE
    patch '/lists/:id' do
        @list = List.find_by_id(params[:id])
        if params[:content] == ""
            redirect to "/lists/#{@list.id}/edit"
        else
            @list.update(content: params[:content])
            @list.save
            redirect to "/lists/#{@lists.id}"
        end
    end

    #DELETE
    delete '/lists/:id' do
        list = List.find_by_id(params[:id])
        if logged_in?
            if current_user.id == list.user_id
                list.delete
            else
                redirect to '/lists'
            end
        else
            redirect to '/login'
        end
    end

end