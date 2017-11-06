json.extract! message, :id, :conversation_id, :sender_id, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
