class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :birthday
    # passwordは半角英数字
    with_options format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
                           message: 'is invalid. Include both letters and numbers' } do
      validates :password
    end
    # lastname, firstnameは全角入力
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' } do
      validates :lastname
      validates :firstname
    end
    # lastname_kana,firstname_kanaは全角カタカナ
    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' } do
      validates :lastname_kana
      validates :firstname_kana
    end
  end

  has_many :items
end
