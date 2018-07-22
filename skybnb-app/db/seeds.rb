User.create!(fullname:  "Zalan Host",
             email: "z@example.com",
             password: "foobar",
             user_type: "host",
             phone_number: "074412345",
             description: "Hello. I'm Zalan..  :)")

User.create!(fullname:  "Zalan Guest",
             email: "z2@example.com",
             password: "foobar",
             user_type: "guest",
             phone_number: "074412346",
             description: "Hello. I'm Zalan..  :)")
             
User.create!(fullname:  "Zalan London",
             email: "zlondon@example.com",
             password: "foobar",
             user_type: "host",
             phone_number: "074412345",
             description: "Hello. I'm Zalan..  :)")

User.create!(fullname:  "Zalan New York",
             email: "znewyork@example.com",
             password: "foobar",
             user_type: "host",
             phone_number: "074412345",
             description: "Hello. I'm Zalan..  :)")
             
Admin.create!(email: "zadmin@example.com",
              password: "foobar")

Room.create!(home_type: "House",
              room_type: "Entire",
              accommodate: 4,
              bed_room: 2,
              bath_room: 1,
              listing_name: "Nice house from 20 minutes from the city center",
              summary: "Come to my tiny house in Aberdeen to spend a great time here",
              address: "19 Summerfield Terrace Aberdeen UK",
              is_heating: true,
              is_internet: true,
              is_kitchen: true,
              price: 10,
              active: true,
              house_rules: "No smoking, no house party",
              user_id: 1)

              
Reservation.create!(user_id: 2,
                    room_id: 1,
                    start_date: 10.minutes.ago,
                    end_date: 1.days.from_now,
                    price: 10,
                    total: 10,
                    status: true)
                    
Review.create!(comment: "Cool flat with a nice view. Definitely recommended :) ",
                star: 4,
                room_id: 1,
                user_id: 2)
                
Conversation.create!(sender_id: 2,
                      recipient_id: 1)

Message.create!(content: "Hello Zalan.",
                conversation_id: 1,
                user_id: 1)

Message.create!(content: "Hello my friend.",
                conversation_id: 1,
                user_id: 2)
                
for i in 1..20 do              
  Room.create!(home_type: "House",
                room_type: "Entire",
                accommodate: 4,
                bed_room: 2,
                bath_room: 1,
                listing_name: "Nice house from #{i} minutes from the city center",
                summary: "Come to my tiny house in Aberdeen to spend a great time here",
                address: "#{i} Summerfield Terrace Aberdeen UK",
                is_heating: true,
                is_internet: true,
                is_kitchen: true,
                price: 5+i,
                active: true,
                house_rules: "No smoking, no house party",
                user_id: 1)
end

for i in 1..20 do              
  Room.create!(home_type: "House",
                room_type: "Entire",
                accommodate: 4,
                bed_room: 2,
                bath_room: 1,
                listing_name: "Nice house from #{i} minutes from the city center",
                summary: "Come to my tiny house in London to spend a great time here",
                address: "#{i} George Street London UK",
                is_heating: true,
                is_internet: true,
                is_kitchen: true,
                price: 5+i,
                active: true,
                house_rules: "No smoking, no house party",
                user_id: 3)
end

for i in 1..20 do              
  Room.create!(home_type: "House",
                room_type: "Entire",
                accommodate: 4,
                bed_room: 2,
                bath_room: 1,
                listing_name: "Nice house from #{i} minutes from the city center",
                summary: "Come to my tiny house in New York to spend a great time here",
                address: "#{i} Church Ave, Brooklyn, NY 11203 USA",
                is_heating: true,
                is_internet: true,
                is_kitchen: true,
                price: 5+i,
                active: true,
                house_rules: "No smoking, no house party",
                user_id: 4)
end

for i in 3..20
    Reservation.create!(user_id: 2,
                    room_id: i,
                    start_date: i.days.ago,
                    end_date: (i-2).days.ago,
                    price: 10,
                    total: 10,
                    status: true)
end


for i in 30..50
    Reservation.create!(user_id: 1,
                    room_id: i,
                    start_date: i.days.ago,
                    end_date: (i-2).days.ago,
                    price: 10,
                    total: 10,
                    status: true)
end