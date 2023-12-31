class AddUserToProjects < ActiveRecord::Migration[7.1]
  def change
    add_reference :projects, :user, foreign_key: true
  end
end
