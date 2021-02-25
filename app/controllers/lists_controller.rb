require 'rack-flash'
class ListsController < ApplicationController
    use Rack::Flash

    get '/new' do
        erb :'lists/new'
    end
    
    get '/lists' do
        erb :'lists/lists'
    end

    get '/lists/:slug' do
        category_array = params[:slug].split("-")
        @category = category_array.join("_")
        @lists = List.send(@category).sort_by {|obj| obj.user_id}
        @category_heading = ""
        category_array.each do |word|
            if word == "and"
                @category_heading += word + " "
            else
                @category_heading += word.capitalize + " "
            end
        end
        erb :'/lists/show_category'
    end

    get '/lists/:category/:id' do
        @list = List.find_by_id(params[:id])
        @user = User.find_by_id(@list.user_id)
        @list_content = @list.content.split("- ")
        @category = create_category_heading(params[:category])
        erb  :'lists/show_list'
    end

    get '/lists/:category/:id/edit' do
        @list = List.find_by_id(params[:id])
        @category = params[:category]
        @list_content = @list.content.split("- ")
        if logged_in?
            if current_user == @list.user
                erb :'lists/edit'
            else
                flash[:notice] = "You are now allowed to edit another user's list."
                redirect to "/lists/#{@category}/#{@list.id}"
            end
        else
            flash[:notice] = "You must be logged in to edit your list."
            redirect to '/login'
        end
    end

    post '/lists' do
        if logged_in?
            if params[:entries].find {|key, value| value == ""} 
                flash[:notice] = "You did not fill out one or more fields."
                redirect to '/new' 
            else
                list_content = ""
                params[:entries].each do |key, value|
                    if value == params[:entries].values.last
                        list_content += value
                    else
                        list_content += value + "- "
                    end
                end
                @user = current_user
                @list = List.create(title: params[:title], category: params[:category].to_sym, content: list_content, user_id: @user.id)
                @user.lists << @list
                redirect to "/lists/#{@list.category}/#{@list.id}"
            end
        else
            flash[:notice] = "You must be logged in to create a new list."
            redirect to '/login'
        end
    end

    patch '/lists/:category/:id' do
        @list = List.find_by_id(params[:id])
        @category = @list.category
        if params[:entries].find {|key, value| value == ""} 
            flash[:notice] = "You left one or more fields blank."
            redirect to "/lists/#{@list.category}/#{@list.id}/edit"
        else
            list_content = ""
                params[:entries].each do |key, value|
                    if value == params[:entries].values.last
                        list_content += value
                    else
                        list_content += value + "- "
                    end
                end
            @list.update(title: params[:title], category: params[:category].to_sym, content: list_content)
            @list.save
            redirect to "/lists/#{@list.category}/#{@list.id}"
        end
    end

    delete '/lists/:category/:id' do
        list = List.find_by_id(params[:id])
        category = params[:category]
        if logged_in?
            if current_user.id == list.user_id
                list.delete
                redirect to '/lists'
            else
                flash[:notice] = "You are now allowed to delete another user's list."
                redirect to "/lists/#{category}/#{params[:id]}"
            end
        else
            flash[:notice] = "You must be logged in to delete your list."
            redirect to '/login'
        end
    end

end