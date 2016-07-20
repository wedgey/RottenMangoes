class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    
    @movies = @movies.where("title like ?", "%#{search_params[:title]}%") unless search_params[:title].nil?
    @movies = @movies.where("director like ?", "%#{search_params[:director]}%") unless search_params[:director].nil?
    case search_params[:duration]
    when 'Under 90 minutes'
      @movies = @movies.where("runtime_in_minutes < 90")
    when 'Between 90 and 120 minutes'
      @movies = @movies.where("runtime_in_minutes BETWEEN 90 AND 120")
    when 'Over 120 minutes'
      @movies = @movies.where("runtime_in_minutes > 120")
    end
    # @movies = Movie.where(search_params)
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
      :title, :director, :duration
    )
  end

end