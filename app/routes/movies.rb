class App
  namespace '/movies' do
    get do
      movies = Movie.paginate(page: params[:page])
      mustache :'movies/index', locals: {movies: movies.as_json}
    end

    post do

    end

    get '/all.json' do
      content_type :json
      param :page, Integer
      param :per_page, Integer

      movies = Movie.paginate(page: params[:page], per_page: params[:per_page])
      logger.debug movies
      json movies
    end
  end
end
