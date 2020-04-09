class App
  namespace '/movies' do
    get do
      data = {
        movies: [
          {'name' => "Star Wars", 'price' => '10.99'},
          {'name' => "Star Trek", 'price' => '14.99'}
        ]
      }
      liquid :'movies/index', locals: data
    end
  end
end
