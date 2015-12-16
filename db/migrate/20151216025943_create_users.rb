class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :project_repo
      t.string :project_url

      t.timestamps null: false
    end
  end
end
