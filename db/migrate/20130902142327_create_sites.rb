class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :link
      t.string :stype
      t.text :description
      t.boolean :is_active

      t.timestamps
    end
  end
end
