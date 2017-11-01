class Artist < ApplicationRecord
  include ImageUploader[:image]

  has_and_belongs_to_many :members

  def self.search(query)
    where("name ilike ?", "%#{query}%")
  end
end
