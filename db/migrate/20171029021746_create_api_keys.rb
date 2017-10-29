class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.string :auth_token
      t.references :application, foreign_key: true

      t.timestamps
    end
    add_index :api_keys, :auth_token, unique: true
  end
end
