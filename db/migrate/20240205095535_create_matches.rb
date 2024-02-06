class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :player_a
      t.string :player_b
      t.string :winner_name

      t.timestamps
    end
  end
end
