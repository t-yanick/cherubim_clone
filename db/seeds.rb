# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Role.find_or_create_by!(name: "admin") do |r|
    r.read_customers = true
    r.create_customers = true
    r.update_customers = true
    r.delete_customers = true

    r.read_goods = true
    r.create_goods = true
    r.update_goods = true
    r.delete_goods = true

    r.read_deposits = true
    r.create_deposits = true
    r.update_deposits = true
    r.delete_deposits = true

    r.read_receipts = true
    r.create_receipts = true
    r.update_receipts = true
    r.delete_receipts = true


    r.create_roles = true
    r.read_roles = true
    r.update_roles = true
    r.delete_roles = true
end
Role.find_or_create_by!(name: "employee") do |r|
    r.read_deposits = true
    r.create_deposits = true
    r.update_deposits = true
    r.delete_deposits = true

    r.read_receipts = true
    r.create_receipts = true
    r.update_receipts = true
    r.delete_receipts = true

    r.read_customers = true
    r.create_customers = true
    r.update_customers = true
    r.delete_customers = true
end

admin = CherubimUser.new(email: "test@user.com",
    encrypted_password: "123456",
    password: "123456",
    first_name: "che",
    last_name: "nsoh",
    Nic: "111",
    Dob: "Tue, 31 Oct 2023",
    role_id: 1,
    country: "Cameroon")
admin.skip_confirmation!
admin.save!