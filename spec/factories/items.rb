FactoryBot.define do
  factory :item do
    title { Faker::Lorem.sentence }
    detail { Faker::Lorem.paragraph }
    category_id { 2 }
    condition_id { 2 }
    shipcost_id { 2 }
    place_id { 2 }
    shipdate_id { 2 }
    price { "1234567" }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
