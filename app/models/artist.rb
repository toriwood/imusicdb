class Artist < ActiveRecord::Base
	has_many :songs, dependent: :destroy
	validates :name, presence: true
	validates :name, uniqueness: true

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
