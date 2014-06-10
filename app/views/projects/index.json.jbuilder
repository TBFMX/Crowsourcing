json.array!(@projects) do |project|
  json.extract! project, :id, :name, :monetary_goal, :init_date, :finish_date
  json.url project_url(project, format: :json)
end
