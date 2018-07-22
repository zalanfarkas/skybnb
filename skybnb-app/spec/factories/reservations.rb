FactoryGirl.define do
  factory :reservation, class: Reservation do
    id 1
    user_id 1
    room_id 1
    start_date "2017-04-17 18:54:04"
    end_date "2017-04-17 18:54:04"
    price 10
    total 20
  end
  factory :reservation2, class: Reservation do
    id 1
    user_id 2
    room_id 1
    start_date "2017-04-17 18:54:04"
    end_date "2017-04-17 18:54:04"
    price 10
    total 20
  end
  factory :reservation3, class: Reservation do
    id 1
    user_id 2
    room_id 1
    start_date "2017-04-19 18:54:04"
    end_date "2017-04-20 18:54:04"
    price 10
    total 20
  end
  factory :reservation4, class: Reservation do
    id 1
    user_id 2
    room_id 1
    start_date "2017-04-26 18:54:04"
    end_date "2017-04-27 18:54:04"
    price 10
    total 20
  end
  
end
