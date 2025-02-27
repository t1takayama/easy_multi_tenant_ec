FactoryBot.define do
  factory :tenant do
    name { 'tenant1'  }
    domain { 'www.example.com' }
    status { 'normal' }
  end
end
