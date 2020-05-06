class CreateEventAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :event_attendances do |t|
      t.integer :attendee_id
      t.integer :attended_event_id

      t.timestamps
    end
    add_index :event_attendances, :attendee_id
    add_index :event_attendances, :attended_event_id
    add_index :event_attendances, [:attendee_id, :attended_event_id], unique: true
  end
end
