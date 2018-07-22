class UserPhoto < ApplicationRecord
  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, :default_url => 'http://vignette1.wikia.nocookie.net/questworld/images/4/47/Comic_image_missing.png/revision/latest?cb=20100421133705'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
