class App
  puts 'loaded'
  namespace '/movies' do
    get do
      mustache 'movies/index'
    end
  end
end
