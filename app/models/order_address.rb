class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postalcode, :prefecture, :municipalities, :street_address, :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postalcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipalities
    validates :street_address
    with_options length: { minimum: 10 } do
      validates :phone_number, format: { with: /\A[0-9]\z/, message: 'is invalid. Input only number' }
    end
  end
  def save
    order = Order.create(item_id: item_id, user_id: user_id) # rubocop:disable Style/HashSyntax
    Address.create(postalcode: postalcode, prefecture: prefecture, municipalities: municipalities, # rubocop:disable Style/HashSyntax
                   street_address: street_address, building_name: building_name, phone_number: phone_number, order_id: order.id) # rubocop:disable Style/HashSyntax
  end
end
