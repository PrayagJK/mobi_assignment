class AddColumnsToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :name, :string
    add_column :courses, :description, :text
  end
end
