class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.string     :image_url
    	t.string     :first_name
    	t.string     :last_name
    	t.references :user
    	

      t.timestamps null: false
    end
  end
end
