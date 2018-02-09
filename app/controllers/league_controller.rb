class LeagueController < ApplicationController
    
    def index
        
        @years = Season.distinct.pluck(:year)

        @leagues = League.all
        
        @selectYear = sort_column
        
        
    end
    
    def show
        @league = League.find(params[:id])
        @season = Season.find(params[:season_id])
        @teams = Competition.where(league_id: params[:id], season_id: params[:season_id]).first.teams
        
        @teams = @teams.sort_by &:elo
        
        @teams.reverse!
        
        @stats = Hash.new
        
        @teams.each do |team|
            @stats = @stats.merge!(cal_stats(team.id))
        end
    end
    
    private
    
        def sort_column
            
            permited_coloumns = Season.distinct.pluck(:year)
            
            permited_coloumns.include?(params[:year].to_i) ? params[:year] : "2016"
           
        end
    
        #got to move to helper
        def cal_stats(id)
            win = 0
            lose = 0
            tie = 0

            goals_for = Team.get_gf(id)
        
            goals_against = Team.get_ga(id)
        
        
            win = Team.get_wins(id)
        
            lose = Team.get_loses(id)
        
            tie = Team.get_ties(id)
        
            return { id => { :wins => win, :loses => lose, :ties => tie, :gf => goals_for, :ga => goals_against } }
        
        end
    
end
