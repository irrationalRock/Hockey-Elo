class LeagueController < ApplicationController
    
    def index
        @leagues = League.all
        
    end
    
end
