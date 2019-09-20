class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :bio
      t.string :photo
      t.integer :role, default: 0
      t.string :remember_digest
      t.string :password_digest
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
