class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :subject
      t.text :body
      t.boolean :is_published
      t.string :picture

      t.timestamps
    end
  end
end
