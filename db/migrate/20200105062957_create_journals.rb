class CreateJournals < ActiveRecord::Migration[6.0]
  def change
    create_table :journals do |t|
      t.string :name
      t.integer :amount
      t.integer :journal_type_id

      t.timestamps
    end
  end
end
