class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :home_team_score
      t.integer :away_team_score
      
      t.integer :home_team_elo
      t.integer :away_team_elo
      t.integer :home_team_change
      t.integer :away_team_change
      
      t.string :venue
      t.datetime :date
      t.timestamps
    end
  end
end
