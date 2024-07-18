class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping
  belongs_to :prefecture
  belongs_to :delivery_time

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :category_id, :condition_id, :shipping_id, :prefecture_id, :delivery_time_id, :image

    with_options numericality: { only_integer: true, greater_than_or_equal_to: 300,
                                 message: 'must be greater than or equal to 300' } do
      with_options numericality: { less_than_or_equal_to: 9_999_999, message: 'must be less than or equal to 9999999' } do
        with_options format: { with: /\A[0-9]+\z/ } do
          validates :price
        end
      end
    end

    with_options length: { maximum: 40 } do
      validates :name
    end

    with_options length: { maximum: 1000 } do
      validates :text
    end
  end
end
