class AddLocationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :location, :string
  end
end
