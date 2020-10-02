class UserController < ApplicationController
    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        @user = User.new(
            username: params[:username], 
            password: params[:password]
        )
        if @user.save
            session[:user_id] = @user.id
            flash[:message] = "Welcome #{@user.username} to the VQ Family!"
            redirect "/users/#{@user.id}"
        else
            flash[:error] = "Couldn't sign you up, #{@user.errors.full_messages.to_sentence}!"
            redirect "/users/signup"
        end
    end

    get '/users/login' do
        if logged_in?
            @user = User.find(session[:user_id])
            redirect "/users/#{@user.id}"
        else
            erb :'/users/login'
        end
    end

    post '/users/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Welcome back #{@user.username}"
            redirect "/users/#{@user.id}"
        else
            flash[:error] = "Invalid username or password. Try again!"
            redirect '/users/login'
        end
        
    end

    get '/users/logout' do 
        session.clear
        redirect '/'
    end

    get '/users/:id' do 
        @user = User.find(session[:user_id])
        erb :'/users/show'
    end
end