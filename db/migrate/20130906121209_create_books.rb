class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :user, index: true
      t.string :name
      t.string :language
      t.integer :rating
      t.string :contributor
      t.string :picture
      t.date :publication_date
      t.string :ISBN
      t.string :btype

      t.timestamps
    end
  end
end
