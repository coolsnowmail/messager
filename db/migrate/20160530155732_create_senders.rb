class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.string :name
      t.string :session
      
      t.timestamps null: false
    end
  end
end
