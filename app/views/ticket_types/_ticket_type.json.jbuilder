json.extract! ticket_type, :id, :price, :name, :created_at, :updated_at
json.url ticket_type_url(ticket_type, format: :json)
