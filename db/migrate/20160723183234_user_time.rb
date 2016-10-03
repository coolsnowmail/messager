class UserTime < ActiveRecord::Migration
  def change
    add_column :users, :user_time, :integer
  end
end
