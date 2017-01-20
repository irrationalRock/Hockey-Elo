class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :location
      t.string :league_id
      
      t.integer :elo, default:1500
      t.string :skill_level
      t.string :age_group
      t.timestamps
    end
  end
end
