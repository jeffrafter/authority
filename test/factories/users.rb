Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.password              { "password" }
  user.password_confirmation { "password" }
end

Factory.define :confirmed_user, :class => 'user' do |user|
  user.email                 { Factory.next :email }
  user.confirmed             { true }
  user.password              { "password" }
  user.password_confirmation { "password" }
end
