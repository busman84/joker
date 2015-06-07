class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.text :setup, :null => false
      t.text :punchline, :null => false

      t.timestamps null: false
    end
  end
end
