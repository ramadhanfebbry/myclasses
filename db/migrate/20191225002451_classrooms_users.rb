class ClassroomsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :classrooms_users, id: false do |t|
      t.belongs_to :classroom
      t.belongs_to :user
    end
  end
end
