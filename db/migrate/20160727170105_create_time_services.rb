class CreateTimeServices < ActiveRecord::Migration
  def change
    create_table :time_services do |t|
      t.integer    :week_day
      t.datetime    :from
      t.datetime    :till
      t.belongs_to :service_user, index: true

      t.timestamps null: false
    end
  end
end
