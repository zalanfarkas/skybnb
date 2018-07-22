FactoryGirl.define do
  factory :room do
    id 1
    home_type "House"
    room_type "Shared"
    accommodate 4
    bed_room 3
    bath_room 1
    listing_name "Tiny house in the city center"
    summary "Cool House in Aberdeen"
    address "9 Jasmine Terrace Aberdeen UK"
    is_tv false
    is_kitchen true
    is_air false
    is_heating true
    is_internet true
    price 10
    active true
    house_rules "No smoking"
    user_id 1
  end
  factory :room2, class: Room do
    id 2
    home_type "House"
    room_type "Entire"
    accommodate 2
    bed_room 1
    bath_room 1
    listing_name "Tiny house in the city center"
    summary "Cool House in Aberdeen"
    address "8 Jasmine Terrace Aberdeen UK"
    is_tv false
    is_kitchen true
    is_air false
    is_heating true
    is_internet true
    price 10
    active true
    house_rules "No smoking"
    user_id 1
  end
end
