class ModifyPlans < ActiveRecord::Migration[7.0]
  def change
    change_column :plans, :profit, :float
    change_column :plans, :penalty, :float
    add_column :plans, :min_depost, :integer
  end
end
