class ForMessageClassColomn < ActiveRecord::Migration
  def change
    add_column :messages, :incoming, :boolean, default: false
  end
end
