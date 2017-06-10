class SeasonController < ApplicationController
    
    def index
        @seasons = Season.where(year: 2016)
        
        #need to create has that has key of season id and value be the top teams id
        #@derp = Array.new
        @season_top_teams = Hash.new
        @collectTeams = Hash.new
        @seasons.each do | season |
             @season_top_teams = @season_top_teams.merge!(Season.get_top_team(season.id))
             #@collectTeams
        end

        #@teams = Team.order(:elo)
        #@stats = Hash.new
        
        #@teams.each do |team|
        #    @stats = @stats.merge!(cal_stats(team.id))
        #end
    end
    
    def show
        @season = Season.find(params[:id])
        
        @teams = Team.where(season: @season).order("elo desc")
        
        @stats = Hash.new
        
        @teams.each do |team|
            @stats = @stats.merge!(cal_stats(team.id))
        end
        
        #@season = @season.includes(:teams).order("teams.elo desc")
        #@age_groups = AgeGroup.includes(:teams).order("teams.elo desc")
    end
    
    private
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
