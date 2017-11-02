json.extract! release, :id, :title, :catalogue_number, :format, :country_code, :released_at, :image_data, :artist_id, :created_at, :updated_at
json.url release_url(release, format: :json)
