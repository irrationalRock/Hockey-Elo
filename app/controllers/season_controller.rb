class SeasonController < ApplicationController
    
    def index
        
        @seasons = Season.where(year: sort_column)
        
        @years = Season.distinct.pluck(:year)
        
        #create has key of season id and value be the top teams id
        @season_top_teams = Hash.new
        @seasons.each do | season |
             @season_top_teams = @season_top_teams.merge!(Season.get_top_team(season.id))
        end
        
        @season_list = block_season(@seasons)

    end
    
    def show
        @season = Season.find(params[:id])
        
        test = Season.find(params[:id]).competitions.includes(:league)
        
        @teams = Array.new
        
        test.each do | x |
           @teams += x.teams 
        end
        
        @teams = @teams.sort_by &:elo
        
        @teams.reverse!
        
        @stats = Hash.new
        
        @teams.each do |team|
            @stats = @stats.merge!(cal_stats(team.id))
        end
        
    end
    
    private
    
        def block_season(seasons)
            #need to create hashes for each different skill_level
            sep_groups = Hash.new
            
            skill_levels = Season.distinct.pluck(:skill_level)
            
            skill_levels.each do | level |
                
                tmp_level = seasons.select { | x |
                    x.skill_level == level.to_s

                }
                
                sep_groups[level.to_s] = split_array(tmp_level)
            end
            
            sep_groups
            
        end
        
        def split_array(array)
            collect = []
            
            array.each_slice(3) { | a |
                #p a
                collect << a
            }
            
            collect
        end
    
        def sort_column
            
            permited_coloumns = Season.distinct.pluck(:year)
            
            permited_coloumns.include?(params[:year].to_i) ? params[:year] : 2016

           
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
