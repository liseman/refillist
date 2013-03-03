class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :shelf_id
      t.string :name
      t.string :description
      t.string :tag
      t.integer :amount

      t.timestamps
    end
  end
end
