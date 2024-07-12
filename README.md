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
| birthday_y_id      | string | null: false                |
| birthday_m_id      | string | null: false                |
| birthday_d_id      | string | null: false                |


### Association

- has_many :items
- has_many :orders

## items table
| Column           | Type    | Options     |
|------------------|---------|-------------|
| name             | string  | null: false |
| image            | text    | null: false |
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

| Column | Type | Options |
|--------|------|---------|

### Association

- belongs_to :user
- belongs_to :user
- has_one :address

## address table

| Column         | Type    | Options     |
|----------------|---------|-------------|
| postalcode     | integer | null: false |
| prefectures_id | integer | null: false |
| municipalities | integer | null: false |
| street_address | string  | null: false |
| building_name  | string  |             |
| phone_number   | string  | null: false, unique: true |

### Association

- belongs_to :order
