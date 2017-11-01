class ArtistMember < ApplicationRecord
  belongs_to :artist
  belongs_to :member
end
