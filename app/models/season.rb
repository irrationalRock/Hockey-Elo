class Season < ApplicationRecord
    belongs_to :league
    has_many :teams
    
    #gets the top 5 teams in a seasons sorted by ELO
    def self.get_top_team(id) 
        stuff = Season.find(id).teams.order("elo desc").first(5)
        
        return { id =>  stuff  }
    end
    
    def self.get_top_team_all_league(_age_group,_skill_level,_year) 
        #stuff = Season.where(age_group: _age_group, skill_level: _skill_level, year: _year)
        #test = Hash.new
        #stuff.teams.each do | team |
        #    test += team
        #end
        #stuff.teams.order("elo desc").first(5)
        
        #return { stuff  }
    end
    
    def self.get_gpg_position(season_id, team_id)
        #teams = Season.find(season_id).teams.get_gf(team_id) / Season.find(season_id).teams.get_games_count(team_id)
        
        
    end
    
end
