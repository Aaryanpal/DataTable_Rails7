class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :categories
      t.integer :current_price
      t.integer :actual_price
      t.integer :discount
      t.float :rating

      t.timestamps
    end
  end
end
