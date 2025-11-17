class AddPhoneToPlayers < ActiveRecord::Migration[8.1]
  def change
    add_column :players, :phone, :string
  end
end
