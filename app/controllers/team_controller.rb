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
        
        
        #@teams.each do |team|
        #    @stats = @stats.merge!(cal_stats(team.id))
        #end
        
    end
    
    def show
        @team = Team.find(params[:id])
        @games = Team.get_games(params[:id])
        
        @games = @games.sort do |x , y |
            x.date <=> y.date
        end
        
    end

    
    #create own class
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
    

    
    private
        #can't use this on wins, loses, or ties because those colomuns are not on team
        def sort_column
            #replace with permit
            permited_coloumns = ["W","L"]
            if params[:sort] == "W" || params[:sort] == "L" || params[:sort] == "T" || params[:sort] == "GF" || params[:sort] == "GA"
                params[:sort]
            else
                #Team.column_names.include?(params[:sort]) ? params[:sort] : "PTS"
                return "PTS"
            end
        end
  
        def sort_direction
            %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
        end
end
