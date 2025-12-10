class Movie < ActiveRecord::Base
  require 'uri'
  require 'json'
  require 'faraday'

  def self.find_in_tmdb(params)
    api_key = 'YOUR_TMDB_API_KEY'  # Replace with real key or use ENV variable
    title = URI.encode(params[:title])
    year_query = params[:release_year].present? ? "&year=#{params[:release_year]}" : ""
    language = params[:language] || 'en'

    url = "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{title}&language=#{language}#{year_query}"

    response = Faraday.get(url)
    results = JSON.parse(response.body)["results"]

    # Filter out movies already in DB
    results.reject { |m| Movie.exists?(title: m["title"]) }.map do |m|
      Movie.new(
        title: m["title"],
        release_date: m["release_date"],
        rating: "R"  # Placeholder
      )
    end
  end
end
