class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.text :text
    	t.integer :service_id
    	t.integer :sender_id
    	t.integer :user_id
    	t.boolean :status

      t.timestamps null: false
    end
  end
end
