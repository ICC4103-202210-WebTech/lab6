class CreateJoinTableEventsOrganizers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :events, :organizers do |t|
      t.index [:event_id, :organizer_id]
      #t.index [:organizer_id, :event_id]
    end
  end
end
