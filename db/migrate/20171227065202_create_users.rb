class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.text :adress
      t.text :college
      t.text :email

      t.timestamps
    end
  end
end
