FactoryGirl.define do
  factory :host, class: User do
    id 1
    fullname "George Smith"
    email 'z111111122@example.com'
    password 'foobar'
    password_confirmation 'foobar'
    user_type "host"
  end
  
  factory :guest, class: User do
    id 2
    fullname "George Smith"
    email 'z111111133@example.com'
    password 'foobar'
    password_confirmation 'foobar'
    user_type "guest"
  end
  
  factory :user, class: User do
    id 3
    fullname "George Smith"
    email 'z1111111@example.com'
    password 'foobar'
    password_confirmation 'foobar'
    user_type "host"
  end
end
