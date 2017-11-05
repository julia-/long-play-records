class Profile < ApplicationRecord
  include ImageUploader[:image]

  belongs_to :user

  validates :username, presence: true, uniqueness: { message: 'username already taken' }, length: 2..20, format: { without: /\s/, message: 'username must contain no spaces' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :image, presence: true
end
