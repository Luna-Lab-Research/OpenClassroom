class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.references :subject, null: true, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :courses, :name
    add_index :courses, [ :start_date, :end_date ]
  end
end
