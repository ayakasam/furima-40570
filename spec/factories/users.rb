FactoryBot.define do
  factory :user do
    user_name = Gimei.name
    nickname { user_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) + '1a' }
    password_confirmation { password }
    lastname { user_name.last }
    firstname { user_name.first }
    lastname_kana { user_name.last.katakana }
    firstname_kana { user_name.first.katakana }
    birthday { Faker::Date.birthday }
  end
end
