class Micropost < ActiveRecord::Base
  belongs_to :user

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 150}
  validate :picture_size


  private 
  
    #vaidate the size of uploaded file
    def picture_size
      if picture.size > 5.megabyte
        errors.add(:picture, "Size should be less than 1MB")
      end
    end
end
