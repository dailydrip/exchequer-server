class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.references :application, foreign_key: true
      t.string :description
      t.string :name
      t.datetime :due_on
      t.decimal :amount
      t.boolean :deferrable

      t.timestamps
    end
  end
end
