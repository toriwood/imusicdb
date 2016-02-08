class Song < ActiveRecord::Base
	belongs_to :artist
	validates :name, :rating, :artist_id, presence: true
	validates :name, uniqueness: true
end
