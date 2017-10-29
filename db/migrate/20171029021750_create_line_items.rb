class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.references :invoice, foreign_key: true
      t.integer :quantity
      t.decimal :amount
      t.references :offer, foreign_key: true
      t.references :coupon, foreign_key: true

      t.timestamps
    end
  end
end
