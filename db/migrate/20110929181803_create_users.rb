class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username , :null => false, :default => ""
      t.string :password , :null => false, :default => ""
      t.string :name , :null => false, :default => ""
      t.string :email , :null => false, :default => ""
      t.integer :isadmin

      t.timestamps
    end
  end
end
