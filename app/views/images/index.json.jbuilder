json.array!(@images) do |image|
  json.extract! image, :id, :image_url, :galery_id
  json.url image_url(image, format: :json)
end
