json.array!(@videos) do |video|
  json.extract! video, :id, :video_url, :galery_id
  json.url video_url(video, format: :json)
end
