class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.timestamps

      t.references :user
      t.references :post
    end
  end
end
