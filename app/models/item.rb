class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :place
  belongs_to :shipcost
  belongs_to :shipdate

  belongs_to :user
  has_one_attached :image

  validates :image, presence: true, unless: :was_attached?
  validates :title, presence: true
  validates :detail, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipcost_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :place_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipdate_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    format: { with: /\A[0-9]+\z/ }, presence: { message: "can't be blank"}

  def was_attached?
    self.image.attached?
  end
end
