class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, null: false
      t.string :author
      t.string :description
      t.integer :comment_id
      t.timestamps null: false
    end
  end
end
