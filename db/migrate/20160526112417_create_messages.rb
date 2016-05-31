class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text       :text
      t.belongs_to :user, index: true
      t.belongs_to :sender, index: true
      t.belongs_to :service, index: true
      t.integer    :status

      t.timestamps null: false
    end
  end
end
