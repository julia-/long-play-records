json.extract! artist, :id, :name, :biography, :image_data, :discog_number, :created_at, :updated_at
json.url artist_url(artist, format: :json)
