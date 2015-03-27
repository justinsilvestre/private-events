class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.references :creator, index: true
      t.text :description

      t.timestamps null: false
    end
    # add_foreign_key :events, :creators
  end
end
