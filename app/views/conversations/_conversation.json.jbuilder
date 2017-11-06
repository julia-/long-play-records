json.extract! conversation, :id, :buyer_id, :seller_id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
