# README
# テーブル設計

## users

|Column              |Type    |Options                    |
|--------------------|--------|---------------------------|
| name               | string | null: false               |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| date_of_birth      | date   | null: false               |


### Association
- has_many :items
- has_many :purchases
- has_many :addresses


## items

|Column            |Type        |Options                         |
|------------------|------------|--------------------------------|
| detail           | text       | null: false                    |
| category_id      | string     | null: false                    |
| condition_id     | string     | null: false                    |
| pay_for_ship_id  | string     | null: false                    |
| ship_from_id     | string     | null: false                    |
| ship_date_id     | string     | null: false                    |
| price            | string     | null: false                    |
| user             | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :purchase
- has_one :address


## purchases

|Column |Type        |Options                         |
|-------|------------|--------------------------------|
| item  | references | null: false, foreign_key: true |
| user  | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :address


## addresses

|Column          |Type        |Options                         |
|----------------|------------|--------------------------------|
| postcode       | string     | null: false                    |
| prefecture_id  | string     | null: false                    |
| city           | string     | null: false                    |
| block_number   | string     | null: false                    |
| apartment_name | string     | null: true                     |
| phone_number   | integer    | null: false                    |
| item           | references | null: false, foreign_key: true |
| user           | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :purchase
