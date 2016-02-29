class CreateGenerators < ActiveRecord::Migration
  def change
    create_table :generators do |t|
      t.float :event1_mean
      t.float :event1_variance
      t.float :event2_mean
      t.float :event2_variance
      t.float :event3_mean
      t.float :event3_variance
      t.float :event4_mean
      t.float :event4_variance
      t.float :event5_mean
      t.float :event5_variance
      t.float :event6_mean
      t.float :event6_variance
      t.float :event7_mean
      t.float :event7_variance
      t.float :event8_mean
      t.float :event8_variance

      t.timestamps
    end
  end
end
