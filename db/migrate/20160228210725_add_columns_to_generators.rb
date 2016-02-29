class AddColumnsToGenerators < ActiveRecord::Migration
  def change
    add_column :generators, :score_8_label, :boolean
    add_column :generators, :score_1_label, :boolean
    add_column :generators, :score_2_label, :boolean
    add_column :generators, :score_3_label, :boolean
    add_column :generators, :score_4_label, :boolean
    add_column :generators, :score_5_label, :boolean
    add_column :generators, :score_6_label, :boolean
    add_column :generators, :score_7_label, :boolean
  end
end
