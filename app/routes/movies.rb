class App
  namespace '/movies' do
    get do
      data = {
        title: 'Movies',
        movies: [
          {'name' => "Star Wars", 'price' => '15.99'},
          {'name' => "Star Trek", 'price' => '9.99'}
        ]
      }
      liquid :'movies/index', locals: data
    end
  end
end
