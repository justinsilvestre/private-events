class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :attendee, index: true
      t.references :attended_event, index: true

      t.timestamps null: false
    end
    add_foreign_key :attendances, :attendees
    add_foreign_key :attendances, :attended_events
  end
end
