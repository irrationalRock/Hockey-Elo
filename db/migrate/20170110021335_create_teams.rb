class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :season_id
      
      t.integer :elo, default:1500

      t.timestamps
    end
  end
end
