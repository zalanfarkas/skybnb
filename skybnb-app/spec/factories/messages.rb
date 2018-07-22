FactoryGirl.define do
  factory :message do
    content "Hello my friend!"
    conversation 1
    user 1
  end
end
