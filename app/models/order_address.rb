class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postalcode, :prefecture_id, :municipalities, :street_address, :building_name, :phone_number,
                :token

  with_options presence: true do
    validates :user_id, :item_id, :token
    validates :postalcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipalities, :street_address
    with_options length: { minimum: 10 } do
      validates :phone_number, format: { with: /\A[0-9]\z/, message: 'is invalid. Input only number' }
    end
  end

  def save
    order = Order.create(user_id:, item_id:)
    Address.create(postalcode:, prefecture:, city:, house_number:,
                   building_name:, donation_id: order.id)
  end
end
