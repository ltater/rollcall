class AddEmailToPlayers < ActiveRecord::Migration[8.1]
  def change
    add_column :players, :email, :string
  end
end
