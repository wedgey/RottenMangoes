class CreateCastings < ActiveRecord::Migration[5.0]
  def change
    create_table :castings do |t|
      t.references :actor, foreign_key: true
      t.references :movie, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
