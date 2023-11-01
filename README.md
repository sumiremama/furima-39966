# README
# テーブル設計

## users

|Column              |Type     |Options                    |
|--------------------|---------|---------------------------|
| fam_name           | string  | null: false               |
| first_name         | string  | null: false               |
| nickname           | string  | null: false               |
| fam_kana           | string  | null: false               |
| first_kana         | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| birthday_id        | date    | null: false               |


### Association
- has_many :items
- has_many :orders


## items

|Column            |Type        |Options                         |
|------------------|------------|--------------------------------|
| title            | string     | null: false                    |
| detail           | text       | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| shipcost_id      | integer    | null: false                    |
| place_id         | integer    | null: false                    |
| shipdate_id      | integer    | null: false                    |
| price            | string     | null: false                    |
| user             | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :order


## orders

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
| place_id       | integer    | null: false                    |
| city           | string     | null: false                    |
| blocknum       | string     | null: false                    |
| apartment      | string     |                                |
| phone          | string     | null: false                    |
| order          | references | null: false, foreign_key: true |


### Association
- belongs_to :order
