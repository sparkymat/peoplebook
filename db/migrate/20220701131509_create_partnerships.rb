# frozen_string_literal: true
class CreatePartnerships < ActiveRecord::Migration[7.0]
  def change
    create_table :partnerships do |t|
      t.references :person1, index: true, foreign_key: {to_table: :people}
      t.references :person2, index: true, foreign_key: {to_table: :people}
      t.date :started_at
      t.date :ended_at

      t.timestamps
    end
  end
end
