class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :question
      t.integer :numOfVotes
      t.integer :parent
      t.integer :rating

      t.timestamps

      t.references :user
    end
  end
end
