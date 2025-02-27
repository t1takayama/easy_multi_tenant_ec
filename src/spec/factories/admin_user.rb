FactoryBot.define do
  factory :admin_user, class: 'admin/user' do
    email { Faker::Internet.unique.email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
  end
end
