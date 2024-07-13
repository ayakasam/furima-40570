# DB設計

## users table

| Column             | Type   | Options                    |
|--------------------|--------|----------------------------|
| nickname           | string | null: false                |
| email              | string | null: false , unique: true |
| encrypted_password | string | null: false                |
| lastname           | string | null: false                |
| lastname_kana      | string | null: false                |
| firstname          | string | null: false                |
| firstname_kana     | string | null: false                |
| birthday           | date   | null: false                |

### Association

- has_many :items
- has_many :orders

## items table
| Column           | Type    | Options     |
|------------------|---------|-------------|
| name             | string  | null: false |
| text             | text    | null: false |
| category_id      | integer | null: false |
| condition_id     | integer | null: false |
| shipping_id      | integer | null: false |
| area_id          | integer | null: false |
| delivery_time_id | integer | null: false |
| price            | integer | null: false |

### Association

- belongs_to :user
- has_one :order

## orders table

| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## address table

| Column         | Type       | Options     |
|----------------|------------|-------------|
| postalcode     | string     | null: false |
| prefectures_id | integer    | null: false |
| municipalities | string     | null: false |
| street_address | string     | null: false |
| building_name  | string     |             |
| phone_number   | string     | null: false, unique: true |
| oder_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :order
