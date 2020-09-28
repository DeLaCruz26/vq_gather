class CarController < ApplicationController
    get '/cars/new' do
        erb :'/cars/new'
    end

    post '/cars' do
        @car = Car.create(
            make: params[:make],
            model: params[:model],
            year: params[:year]
        )
        redirect "/cars/#{@car.id}"
    end

    get '/cars/:id' do
        @car = Car.find(params[:id])
        erb :'/cars/show'
    end

    get '/cars' do
        @cars = Cars.all
        erb :'/cars/index' 
    end

    get '/cars/:id/edit' do 
        @car = Car.find(params[:id])
        erb :'/cars/edit'
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

    delete '/cars/:id/' do
        @car = Car.find(params[:id])
        @car.destroy
        redirect '/cars'
    end
end