class AddActiveUntilToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :active_until, :date
  end
end
