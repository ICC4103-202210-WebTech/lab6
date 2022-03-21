class Event < ApplicationRecord
    belongs_to :event_venue, optional: true
    has_many :ticket_types
end
