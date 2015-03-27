class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :attendee, index: true
      t.references :attended_event, index: true

      t.timestamps null: false
    end
    add_foreign_key :attendances, :users, :attendee_id
    add_foreign_key :attendances, :events, :attended_event_id
  end
end
