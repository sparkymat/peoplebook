# frozen_string_literal: true
class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :other_names, array: true, default: []

      t.timestamps
    end
  end
end
