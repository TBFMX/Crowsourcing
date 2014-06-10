json.array!(@amends) do |amend|
  json.extract! amend, :id, :user_id, :description, :project_id, :image_id
  json.url amend_url(amend, format: :json)
end
