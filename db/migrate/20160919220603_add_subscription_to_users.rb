class AddSubscriptionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscription, :boolean
  end
end
