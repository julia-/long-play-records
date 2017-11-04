class Release < ApplicationRecord
  belongs_to :artist

  def self.search_database_release(query, artist)
    results = where("title ilike ?", "%#{query}%")
  end

  # def self.search(query, artist)
  #   database_search = search_database_release(query, artist)
  #
  #   if !database_search.empty?
  #     database_search
  #   else
  #     discogs_api_key = ENV.fetch('DISCOGS_API_KEY')
  #     discogs_secret_api_key = ENV.fetch('DISCOGS_SECRET_API_KEY')
  #
  #     response = HTTParty.get("https://api.discogs.com/database/search?release_title=#{query}&artist=#{artist}&format=vinyl&key=#{discogs_api_key}&secret=#{discogs_secret_api_key}")
  #
  #     @release_data = response['results']
  #   end
  # end
end
