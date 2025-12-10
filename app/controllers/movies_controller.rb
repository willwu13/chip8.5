class MoviesController < ApplicationController
  before_action :force_index_redirect, only: [:index]
  skip_before_action :force_index_redirect, only: [:search_tmdb]  # Prevent redirect for TMDb search

  def show
    @movie = Movie.find(params[:id])
  end

  def index
    @all_ratings = Movie.all_ratings
    @movies = Movie.with_ratings(ratings_list, sort_by)
    @ratings_to_show_hash = ratings_hash
    @sort_by = sort_by
    session['ratings'] = ratings_list
    session['sort_by'] = @sort_by
  end

  def new; end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  # ----------------------------
  # TMDb Search
  # ----------------------------
  def search_tmdb
    search_terms = params[:search_terms]

    if search_terms.blank?
      flash[:warning] = "Please fill in all required fields!"
      redirect_to movies_path and return
    end

    @movies = Movie.find_in_tmdb(title: search_terms)

    flash[:notice] = "No movies found with given parameters!" if @movies.empty?

    flash.keep
    render 'search_tmdb'
  end

  private

  def force_index_redirect
    return if params.key?(:ratings) && params.key?(:sort_by)
    flash.keep
    redirect_to movies_path(sort_by: sort_by, ratings: ratings_hash)
  end

  def ratings_list
    params[:ratings]&.keys || session[:ratings] || Movie.all_ratings
  end

  def ratings_hash
    ratings_list.to_h { |item| [item, "1"] }
  end

  def sort_by
    params[:sort_by] || session[:sort_by] || 'id'
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
