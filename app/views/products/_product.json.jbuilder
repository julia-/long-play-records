json.extract! product, :id, :name, :price, :postage, :record_condition, :sleeve_condition, :discogs_id, :description, :user_id, :created_at, :updated_at
json.url product_url(product, format: :json)
