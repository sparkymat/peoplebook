# frozen_string_literal: true
class CreateRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :relations do |t|
      t.references :from, index: true, null: false, foreign_key: {to_table: :people}
      t.references :to, index: true, null: false, foreign_key: {to_table: :people}
      t.string :relation_type, null: false
      t.date :started_at

      t.timestamps
    end
  end
end
