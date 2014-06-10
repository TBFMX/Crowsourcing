json.array!(@funders) do |funder|
  json.extract! funder, :id, :user_id, :perk_id
  json.url funder_url(funder, format: :json)
end
