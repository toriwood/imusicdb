class Artist < ActiveRecord::Base
	has_many :songs
	validates :name, :rating, presence: true
	validates :name, uniqueness: true
end
