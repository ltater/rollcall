class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.date :date
      t.time :time
      t.string :location
      t.integer :home_team_id
      t.integer :away_team_id

      t.timestamps
    end

    add_index :games, :home_team_id
    add_index :games, :away_team_id
    add_foreign_key :games, :teams, column: :home_team_id
    add_foreign_key :games, :teams, column: :away_team_id
  end
end
