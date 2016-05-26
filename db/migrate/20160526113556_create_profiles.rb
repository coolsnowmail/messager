class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.integer :user_id
    	t.string :img_url
    	t.string :first_name
    	t.string :last_name

      t.timestamps null: false
    end
  end
end
