class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postalcode, :prefecture_id, :municipalities, :street_address, :building_name, :phone_number,
                :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postalcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :municipalities
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save(order_params, user_id)
    order = Order.create(item_id: item_id, user_id: user_id) # rubocop:disable Style/HashSyntax
    Address.create(postalcode: postalcode, prefecture_id: prefecture_id, municipalities: municipalities, # rubocop:disable Style/HashSyntax
                   street_address: street_address, building_name: building_name, phone_number: phone_number, order_id: order.id) # rubocop:disable Style/HashSyntax
  end
end
