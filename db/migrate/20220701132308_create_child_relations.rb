# frozen_string_literal: true
class CreateChildRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :child_relations do |t|
      t.references :child, index: true, foreign_key: {to_table: :people}
      t.references :partnership
      t.string :relation_type, default: "regular", null: false

      t.timestamps
    end
  end
end
