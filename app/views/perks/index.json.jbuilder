json.array!(@perks) do |perk|
  json.extract! perk, :id, :title, :description, :delivery_date, :price, :pieces, :project_id, :image_id
  json.url perk_url(perk, format: :json)
end
