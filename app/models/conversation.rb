class Conversation < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :seller, class_name: 'Product'
  has_many :messages
end
