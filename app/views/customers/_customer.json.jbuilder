json.extract! customer, :id, :first_name, :last_name, :telephone, :email, :good_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)
