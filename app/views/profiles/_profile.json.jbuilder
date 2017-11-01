json.extract! profile, :id, :user_id, :username, :first_name, :last_name, :image_data, :created_at, :updated_at
json.url profile_url(profile, format: :json)
