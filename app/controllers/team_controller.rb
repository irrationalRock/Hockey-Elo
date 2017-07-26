class TeamController < ApplicationController
    helper_method :sort_column, :sort_direction
    
    def index
        #remeber ruby uses elsif
        #put a if statement that checks to see what sort column whats to order and orders it appropiaty 
        #remeber that some of the sorts depend on tema and others on games
        
        @teams = Team.all
        
        @stats = Hash.new
        
        @teams.each do |team|
            @stats = @stats.merge!(cal_stats(team.id))
        end
        #move the if statment off the index method
        if sort_column == "W"
            
            if sort_direction == "asc"
                @teams = @teams.sort do |x, y |
                    
                    (@stats[x.id][:wins] ) <=> (@stats[y.id][:wins])
                end
            else
                @teams = @teams.sort do |x, y |
                    (@stats[y.id][:wins] ) <=> (@stats[x.id][:wins])
                end
            end
        
        elsif sort_column == "L"
            
            if sort_direction == "asc"
                @teams = @teams.sort do |x, y |
                    (@stats[x.id][:loses] ) <=> (@stats[y.id][:loses])
                end
            else
                @teams = @teams.sort do |x, y |
                    (@stats[y.id][:loses] ) <=> (@stats[x.id][:loses])
                end
            end
        
        elsif sort_column == "T"
        
            if sort_direction == "asc"
                @teams = @teams.sort do |x, y |
                    (@stats[x.id][:ties] ) <=> (@stats[y.id][:ties])
                end
            else
                @teams = @teams.sort do |x, y |
                    (@stats[y.id][:ties] ) <=> (@stats[x.id][:ties])
                end
            end
            
        elsif sort_column == "GF"
            if sort_direction == "asc"
                @teams = @teams.sort do |x, y |
                    (@stats[x.id][:gf] ) <=> (@stats[y.id][:gf])
                end
            else
                @teams = @teams.sort do |x, y |
                    (@stats[y.id][:gf] ) <=> (@stats[x.id][:gf])
                end
            end
        elsif sort_column == "GA"
            if sort_direction == "asc"
                @teams = @teams.sort do |x, y |
                    (@stats[x.id][:ga] ) <=> (@stats[y.id][:ga])
                end
            else
                @teams = @teams.sort do |x, y |
                    (@stats[y.id][:ga] ) <=> (@stats[x.id][:ga])
                end
            end
            
        elsif sort_column == "ELO"
            @teams = Team.order(sort_column + ' ' + sort_direction)
            
        elsif sort_column == "DIFF"
        
            if sort_direction == "asc"
                @teams = @teams.sort do |x, y |
                    (@stats[x.id][:gf] - @stats[x.id][:ga] ) <=> (@stats[y.id][:gf] - @stats[y.id][:ga] )
                end
            else
                @teams = @teams.sort do |x, y |
                    (@stats[y.id][:gf] - @stats[y.id][:ga] ) <=> (@stats[x.id][:gf] - @stats[x.id][:ga] )
                end
            end
            
        elsif sort_column == "PTS"
            #use if you have to access elo and sort 
            #@teams = Team.order(sort_column + ' ' + sort_direction)
            
            if sort_direction == "asc"
                @teams = @teams.sort do |x, y |
                    (@stats[x.id][:wins] * 2 + @stats[x.id][:ties] ) <=> (@stats[y.id][:wins] * 2 + @stats[y.id][:ties] )
                end
            else
                @teams = @teams.sort do |x, y |
                    (@stats[y.id][:wins] * 2 + @stats[y.id][:ties] ) <=> (@stats[x.id][:wins] * 2 + @stats[x.id][:ties] )
                end
            end
            
            
        end
        
        
    end
    
    def show
        #need to have safe params method to check
        @team = Team.find(params[:id])
        games = Team.get_games(params[:id])
        @stat = cal_stats(@team.id)
        
        @test = Array.new
        
        #need to move to get_games method
        @test = games.sort do |x , y |
            x.date <=> y.date
        end
        #need to make more efficifent 
        #games = games.each do | x |
        #    if x.date.mon == 9 || x.date.mon == 10 || x.date.mon == 11 || x.date.mon == 12
        #       @test << x 
        #    end
        #end
        
        #games = games.each do | x |
        #    if x.date.mon == 1 || x.date.mon == 2 || x.date.mon == 3 || x.date.mon == 4
        #       @test << x 
        #    end
        #end
        
    end

    
    private
    
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
        
        #can't use this on wins, loses, or ties because those colomuns are not on team
        def sort_column
            
            permited_coloumns = ["W","L","T","GF","GA","ELO","DIFF"]
            
            permited_coloumns.include?(params[:sort]) ? params[:sort] : "PTS"
            
            #Team.column_names.include?(params[:sort]) ? params[:sort] : "PTS"
           
        end
  
        def sort_direction
            %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
        end
        
        
end
