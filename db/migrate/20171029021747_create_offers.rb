class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.references :application, foreign_key: true
      t.string :description
      t.string :name
      t.string :due_on
      t.string :datetime
      t.decimal :amount
      t.boolean :deferrable

      t.timestamps
    end
  end
end
