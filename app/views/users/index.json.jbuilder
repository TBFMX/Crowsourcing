json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :nombre
  json.url user_url(user, format: :json)
end
