class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.string :name
      t.string :session
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
