class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :player_a
      t.string :player_b
      t.string :winner

      t.timestamps
    end
  end
end
