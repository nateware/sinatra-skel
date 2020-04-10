class App
  namespace '/movies' do
    get do
      movies = Movie.paginate(page: params[:page])
      # liquid :'movies/index', locals: {movies: movies.as_json}
      mustache :'movies/index', locals: {movies: movies.as_json}
    end

    get '/all.json' do
      movies = Movie.paginate(page: params[:page])
      logger.debug movies
      json movies
    end
  end
end
