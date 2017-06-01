class CreateSeasons < ActiveRecord::Migration[5.0]
  def change
    create_table :seasons do |t|
      t.string :age_group
      t.string :skill_level
      t.integer :year
      
      t.integer :league_id
      
      t.timestamps
    end
  end
end
