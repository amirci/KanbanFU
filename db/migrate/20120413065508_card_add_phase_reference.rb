class CardAddPhaseReference < ActiveRecord::Migration
  def change
    add_column :cards, :phase_id, :int
  end
end
