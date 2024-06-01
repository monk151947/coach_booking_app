class CreateTimeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :time_slots do |t|
      t.boolean :available, default: true
      t.string :start 
      t.references :availability, index: true

      t.timestamps
    end
  end
end
