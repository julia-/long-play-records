class Artist < ApplicationRecord
  include ImageUploader[:image]
end
