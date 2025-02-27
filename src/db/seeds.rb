tenant1 = Tenant.find_or_create_by!(name: 'tenant1') do |tenant|
  tenant.name = 'tenant1'
  tenant.domain = 'tenant1.localhost'
  tenant.status = 'normal'
end

Tenant.find_or_create_by!(name: 'tenant2') do |tenant|
  tenant.name = 'tenant2'
  tenant.domain = 'tenant2.localhost'
  tenant.status = 'closed'
end

Owner.find_or_create_by!(email: 'owner1@tenant1.com') do |owner|
  owner.email = 'owner1@tenant1.com'
  owner.password = 'passw0rd'
  owner.password_confirmation = 'passw0rd'
  owner.tenant_id = tenant1.id
end

Admin::User.find_or_create_by!(email: 'admin1@example.com') do |admin|
  admin.email = 'admin1@example.com'
  admin.password = 'passw0rd'
  admin.password_confirmation = 'passw0rd'
end

Product.find_or_create_by!(name: 'red') do |product|
  product.name = 'red'
  product.description = 'Red product description'
  product.price  = 10000
  product.stock = 100
  product.tenant_id = tenant1.id
  product.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/red.jpeg"), filename: 'red.jepg')
end

Product.find_or_create_by!(name: 'blue') do |product|
  product.name = 'blue'
  product.description = 'Blue product description'
  product.price  = 12000
  product.stock = 100
  product.tenant_id = tenant1.id
  product.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/blue.jpeg"), filename: 'blue.jepg')
end

Product.find_or_create_by!(name: 'yellow') do |product|
  product.name = 'yellow'
  product.description = 'Yellow product description'
  product.price  = 20000
  product.stock = 100
  product.tenant_id = tenant1.id
  product.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/yellow.jpeg"), filename: 'yellow.jepg')
end
