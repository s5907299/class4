json.extract! user, :id, :email, :name, :birthday, :address, :postal_code, :pass, :created_at, :updated_at
json.url user_url(user, format: :json)
