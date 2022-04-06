json.extract! event, :id, :name, :created_at, :updated_at
json.url api_v1_event_url(event, format: :json)
