require 'minitest/autorun'
class MovieTest < Minitest::Test
  def setup
  end

  def test_movie_all
    movies = Movie.all
    refute_empty movies 
  end
end