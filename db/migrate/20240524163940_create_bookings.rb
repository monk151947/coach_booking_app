class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.integer :coach_id, index: true
      t.references :time_slots, null: false, foreign_key: true
      t.integer :student_id, index: true

      t.timestamps
    end
  end
end
