class Product < ApplicationRecord
  has_many :comments
  has_many :product_orders
  has_many :rates
  belongs_to :category
  default_scope -> { order(created_at: :desc) }

  mount_uploader :image, PictureUploader
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :description, presence: true
end
