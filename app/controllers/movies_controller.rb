class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    
    @movies = @movies.better_search(search_params[:q], search_params[:q])
    # @movies = @movies.title_search(search_params[:title]) unless search_params[:title].nil?
    # @movies = @movies.director_search(search_params[:director]) unless search_params[:director].nil?
    case search_params[:duration]
    when 'Under 90 minutes'
      @movies = @movies.under_90_search
    when 'Between 90 and 120 minutes'
      @movies = @movies.between_90_120_search
    when 'Over 120 minutes'
      @movies = @movies.over_120_search
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
    )
  end

  def search_params
    params.permit(
      :q, :duration
    )
  end

end