class Game < ApplicationRecord
    include ELO
    after_create :update_elo
    
    
    belongs_to :away_team, :class_name => "Team"
    belongs_to :home_team, :class_name => "Team"
    #call after_create to update elo
    
    
    private
    
    def update_elo 
        #to get elo
        home_elo_change = elo_change(self.home_team.elo, self.away_team.elo, self.home_team_score - self.away_team_score)
	    
	    Team.update(home_team_id, elo: self.home_team.elo + home_elo_change)
	    Team.update(away_team_id, elo: self.away_team.elo + (-home_elo_change))
	    Game.update(self.id,home_team_change: home_elo_change)
	    Game.update(self.id,away_team_change: -home_elo_change)

    end
    
end
