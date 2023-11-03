FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials }
    fam_name { '山田' }
    first_name { '太郎' }
    fam_kana { 'ヤマダ' }
    first_kana { 'タロウ' }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    birthday { Faker::Date.birthday }
  end
end
