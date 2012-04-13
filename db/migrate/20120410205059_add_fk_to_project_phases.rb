class AddFkToProjectPhases < ActiveRecord::Migration
  def change
    add_column :phases, :project_id, :int
  end
end
