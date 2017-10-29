class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.references :offer, foreign_key: true
      t.string :name
      t.decimal :percent_off
      t.string :amount_off
      t.string :decimal

      t.timestamps
    end
  end
end
