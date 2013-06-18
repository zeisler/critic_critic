require_relative '../ApiRTFetch'

a = ApiRTFetch.new

namespace :api do
  desc "Fetch RT API data and create theatrical release Movie instances"
  task get_upcoming_movies: :environment do
    puts "Grabbing upcoming movies..."
    a.get_upcoming_movies
    puts "DONE"
  end

  desc "Fetch RT API data and create upcoming DVD Movie instances"
  task get_upcoming_dvds: :environment do
    puts "Grabbing upcoming DVD releases..."
    a.get_upcoming_dvds
    puts "DONE"
  end

  desc "Fetch RT API data and create Critic and CriticOpinion instances from fetched movie IDs"
  task get_all_reviews: :environment do
    puts "Grabbing reviews for fetched movies..."
    a.get_all_reviews
    puts "DONE"
  end

  desc "Run all API grabs"
  task all: [:get_upcoming_movies, :get_upcoming_dvds, :get_all_reviews]

  desc "clears DB of all instances of movies, critics, and critic_opinions"
  task clear_db: :environment do
    ApiRTFetch.clear_db
  end

end
