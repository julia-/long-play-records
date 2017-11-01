class Artist < ApplicationRecord
  include ImageUploader[:image]

  has_and_belongs_to_many :members
end
