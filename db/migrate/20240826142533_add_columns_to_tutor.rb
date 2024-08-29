class AddColumnsToTutor < ActiveRecord::Migration[7.1]
  def change
    add_column :tutors, :first_name, :string
    add_column :tutors, :last_name, :string
    add_column :tutors, :specialization, :string
    add_reference :tutors, :course, foreign_key: true
  end
end
