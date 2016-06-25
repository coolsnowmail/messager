class ForMessageClassColomn < ActiveRecord::Migration
  def change
    add_column :messages, :incoming, :boolean
  end
end
