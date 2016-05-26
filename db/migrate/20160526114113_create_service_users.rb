class CreateServiceUsers < ActiveRecord::Migration
  def change
    create_table :service_users do |t|
    	t.jsonb :auth_data
    	t.integer :user_id
    	t.integer :service_id

      t.timestamps null: false
    end
  end
end
