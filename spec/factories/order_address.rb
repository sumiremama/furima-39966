FactoryBot.define do
  factory :order_address do
    postcode { '123-4567' }
    place_id { 1 }
    city { '港区' }
    blocknum { '青山1-1' }
    apartment { '東京ハイツ' }
    phone { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
