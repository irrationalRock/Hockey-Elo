class League < ApplicationRecord
    has_many :competitions
    has_many :seasons, through: :competitions
    
    def self.get_place_league(id)
        
    end
    
end
