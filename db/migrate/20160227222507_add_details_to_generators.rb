class AddDetailsToGenerators < ActiveRecord::Migration
  def change
    add_column :generators, :event1_negative_variance, :float
    add_column :generators, :event1_negative_mean, :float
    add_column :generators, :event2_negative_mean, :float
    add_column :generators, :event2_negative_variance, :float
    add_column :generators, :event3_negative_mean, :float
    add_column :generators, :event3_negative_variance, :float
    add_column :generators, :event4_negative_mean, :float
    add_column :generators, :event4_negative_varaince, :float
    add_column :generators, :event5_negative_mean, :float
    add_column :generators, :event5_negative_variance, :float
    add_column :generators, :event6_negative_mean, :float
    add_column :generators, :event6_negative_variance, :float
    add_column :generators, :event7_negative_mean, :float
    add_column :generators, :event7_negative_variance, :float
    add_column :generators, :event8_negative_mean, :float
    add_column :generators, :event8_negative_variance, :float
  end
end
