class CreateAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :day_of_week
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
