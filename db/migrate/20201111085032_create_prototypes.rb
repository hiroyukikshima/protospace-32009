class CreatePrototypes < ActiveRecord::Migration[6.0]
  def change
    create_table :prototypes do |t|
      t.references :user, foreign_key: true
      t.text :concept,    null: false
      t.text :catch_copy, null: false
      t.string :title,    null: false
      t.timestamps
    end
  end
end
