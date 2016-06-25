class VkForUser < ActiveRecord::Migration
  def change
    add_column :users, :vk_user_id, :integer
  end
end
