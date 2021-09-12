class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password_digest, null: false
      t.bigint :gender, null: true
      t.datetime :birthday, null: true
      t.integer :signup_step, null: false, default: 0

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
