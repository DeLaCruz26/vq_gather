class CarController < ApplicationController
    get '/cars/new' do
        if logged_in?
            erb :'/cars/new'
        else
            flash[:error] = "You must be logged in to RSVP for the gather!"
            redirect "/"
        end
    end

    post '/cars' do
        @car = Car.new(
            make: params[:make],
            model: params[:model],
            year: params[:year],
            user_id: current_user.id
        )
        if @car.save
            flash[:message] = "Added car to the gather!"
            redirect "/cars/#{@car.id}"
        else
            flash[:error] = "Couldn't add car to the gather. #{@car.errors.full_messages.to_sentence}!"
            redirect "/cars/new"
        end
    end

    get '/cars/my_garage' do
        @user_cars = current_user.cars
        erb :'/cars/garage'
    end

    get '/cars/:id' do
        @car = Car.find(params[:id])
        if logged_in?
            erb :'/cars/show'
        else
            flash[:error] = "You must be logged in to view the gather!"
            redirect "/"
        end 
    end

    get '/cars' do
        @cars = Car.all
        if logged_in?
            erb :'/cars/index'
        else
            flash[:error] = "You must be logged in to view the gather!"
            redirect "/"
        end 
    end

    get '/cars/:id/edit' do 
        @car = Car.find(params[:id])
        if authorized_to_edit?(@car)
            erb :'/cars/edit'
        else
            flash[:error] = "Not authorized to edit this car!"
            redirect "/cars"
        end
    end

    patch '/cars/:id' do
        @car  = Car.find(params[:id])
        @car.update(
            make: params[:make],
            model: params[:model],
            year: params[:year]
        )
        redirect "/cars/#{@car.id}"
        
    end

    delete '/cars/:id' do
        @car = Car.find(params[:id])
        @car.destroy
        redirect '/cars'
    end
end