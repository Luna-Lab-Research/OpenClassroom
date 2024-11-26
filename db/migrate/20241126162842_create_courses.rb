class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.references :subject, null: true, foreign_key: true

      t.timestamps
    end
  end
end
