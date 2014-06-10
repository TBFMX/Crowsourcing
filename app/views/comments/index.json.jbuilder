json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :project_id, :comments
  json.url comment_url(comment, format: :json)
end
