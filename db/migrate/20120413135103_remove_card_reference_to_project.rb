class RemoveCardReferenceToProject < ActiveRecord::Migration
  def change
    remove_column :cards, :project_id
  end
end
