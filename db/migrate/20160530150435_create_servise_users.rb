class CreateServiseUsers < ActiveRecord::Migration
  def change
    create_table :servise_users do |t|

      t.jsonb      :auth_date
      t.belongs_to :user, index: true
      t.belongs_to :service, index: true

      t.timestamps null: false
    end
  end
end
