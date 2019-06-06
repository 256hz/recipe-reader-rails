class AddStepNoToSteps < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :step_no, :integer
  end
end
