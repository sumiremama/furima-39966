class OrderAddress

  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postcode, :place_id, :city, :blocknum, :apartment, :phone, :token

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :place_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :blocknum
    validates :phone, format: { with: /\A\d{10,11}\z/,message: "is invalid."}, length: {maximum: 11}
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postcode: postcode, place_id: place_id, city: city, blocknum: blocknum, apartment: apartment, phone: phone, order_id: order.id)
  end
end  