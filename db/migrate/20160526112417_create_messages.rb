class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.text       :text
      t.references :user
      t.references :sender
      t.references :service
    	t.boolean    :status

      t.timestamps null: false
    end
  end
end
