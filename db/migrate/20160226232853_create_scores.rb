class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :event1
      t.float :event1_duration
      t.string :event2
      t.float :event2_duration
      t.string :event3
      t.float :event3_duration
      t.string :event4
      t.float :event4_duration
      t.string :event5
      t.float :event5_duration
      t.string :event6
      t.float :event6_duration
      t.string :event7
      t.float :event7_duration
      t.string :event8
      t.float :event8_duration

      t.timestamps
    end
  end
end
