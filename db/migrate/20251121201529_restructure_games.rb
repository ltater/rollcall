class RestructureGames < ActiveRecord::Migration[8.1]
  def change
    # Remove old team associations
    remove_foreign_key :games, column: :home_team_id if foreign_key_exists?(:games, column: :home_team_id)
    remove_foreign_key :games, column: :away_team_id if foreign_key_exists?(:games, column: :away_team_id)
    remove_column :games, :home_team_id
    remove_column :games, :away_team_id

    # Add new structure
    add_reference :games, :team, null: false, foreign_key: true
    add_column :games, :opponent, :string
    add_column :games, :home_away, :string, default: 'home'
  end
end
