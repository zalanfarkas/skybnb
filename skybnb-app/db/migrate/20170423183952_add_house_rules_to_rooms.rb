class AddHouseRulesToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :house_rules, :text
  end
end
