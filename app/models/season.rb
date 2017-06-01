class Season < ApplicationRecord
    belongs_to :league
    has_many :teams
    
    #gets the top 5 teams in a seasons sorted by ELO
    def self.get_top_team(id) 
        stuff = Season.find(id).teams.order("elo desc").first(5)
        
        return { id =>  stuff  }
        
    end
    
end
