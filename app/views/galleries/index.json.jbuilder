json.array!(@galleries) do |gallery|
  json.extract! gallery, :id, :title, :description, :project_id
  json.url gallery_url(gallery, format: :json)
end
