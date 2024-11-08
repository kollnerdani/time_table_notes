class CreateWorkingTimes < ActiveRecord::Migration[7.2]
  def change
    create_table :working_times do |t|
      t.datetime :start_time
      t.references :user, null: false, foreign_key: true
      t.datetime :end_time
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
