json.array!(@rols) do |rol|
  json.extract! rol, :id, :rol_name, :admin, :module_1, :module_2, :module_3, :module_4, :module_5
  json.url rol_url(rol, format: :json)
end
