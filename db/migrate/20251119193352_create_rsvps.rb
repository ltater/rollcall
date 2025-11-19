class CreateRsvps < ActiveRecord::Migration[8.1]
  def change
    create_table :rsvps do |t|
      t.references :game, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.string :status, default: 'pending'

      t.timestamps
    end

    add_index :rsvps, [ :game_id, :player_id ], unique: true
  end
end
