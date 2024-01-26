# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
