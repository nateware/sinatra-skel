class Movie < ActiveRecord::Base
  validates :name, :price, presence: true
end