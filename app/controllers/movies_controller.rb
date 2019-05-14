class MoviesController < ApplicationController

    def index
        movies = Movie.all
        render json:  movies.as_json(only: [:id, :title, :release_date]), status: :ok
    end

    def show
        movie = Movie.find_by(id: params[:id])
        if movie
            render json:  movie.as_json(only: [:id, :title, :overview, :release_date, :inventory, :available_inventory]), status: :ok
        else
            render json: {
                ok: false,
                messages: ["Movie not found"]
            },
            status: :bad_request
        end

    end
    
    def create
        movie = Movie.new(movie_params)
        if movie.save
            render json:  movie.as_json(only: [:id]), status: :ok
        else
            render json: {
                ok: false,
                errors: [movie.errors.messages]
            },
            status: :bad_request
        end

    end
end

private

def movie_params
    params.require(:movie).permit(:id, :title, :overview, :release_date, :inventory)
end

