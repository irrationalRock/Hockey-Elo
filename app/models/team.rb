class Team < ApplicationRecord
    #when calling assoscations from team use home_games and away_games
    #the reason why I could not 
    has_many :home_games, :foreign_key => "home_team_id", :class_name => "Game"
    has_many :away_games, :foreign_key => "away_team_id", :class_name => "Game"
    belongs_to :season
    
    validates :team_name, presence: true
    #nend to get rid of
    #validates :location, presence: true
    #validates :skill_level, presence: true
    #validates :age_group, presence: true
    
    #put the stats method in here
    
    def self.get_games(id)
        Team.find(id).home_games + Team.find(id).away_games
    end
    
    def self.get_wins(id)
        Team.find(id).home_games.where("home_team_score > away_team_score").count + 
        Team.find(id).away_games.where("away_team_score > home_team_score").count
    end
    
    def self.get_loses(id)
        Team.find(id).home_games.where("home_team_score < away_team_score").count +
        Team.find(id).away_games.where("away_team_score < home_team_score").count
    end
    
    def self.get_ties(id)
        Team.find(id).home_games.where("home_team_score = away_team_score").count +
        Team.find(id).away_games.where("away_team_score = home_team_score").count
    end
    
    def self.get_gf(id)
        Team.find(id).home_games.sum(:home_team_score) +
        Team.find(id).away_games.sum(:away_team_score)
    end
    
    def self.get_ga(id)
        Team.find(id).home_games.sum(:away_team_score) +
        Team.find(id).away_games.sum(:home_team_score)
    end
    
end
