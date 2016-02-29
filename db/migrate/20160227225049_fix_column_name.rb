class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :generators, :event4_negative_varaince, :event4_negative_variance 
  end
end
