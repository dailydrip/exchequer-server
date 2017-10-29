class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :offer, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :due_on

      t.timestamps
    end
  end
end
