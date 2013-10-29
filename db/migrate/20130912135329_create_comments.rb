class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.string :parent_id
      t.references :article, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
