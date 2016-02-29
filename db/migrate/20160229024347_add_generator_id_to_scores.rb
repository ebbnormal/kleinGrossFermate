class AddGeneratorIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :generator_id, :integer
  end
end
