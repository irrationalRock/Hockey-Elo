module ELO
    HOME_ADV = 50
    
    #evaluates the elo propbabity of the home elo winning 
    def prop_elo(home_elo,away_elo)
        
        
        elo_prop = (home_elo - away_elo) + HOME_ADV
        
        #puts elo_prop
        
        elo_prop = -elo_prop.to_f / 400.to_f
        
        #puts elo_prop
        
        elo_prop = 10 ** elo_prop.to_f
        
        #puts elo_prop
        
        elo_prop = elo_prop + 1
        
        #puts elo_prop
        
        elo_prop = 1 / elo_prop.to_f
            
        #puts elo_prop
        return elo_prop
    end


    #calulates the change in elo
    def elo_change(home_elo,away_elo,gd)
        #gd has to be from the perspective of home team and needs to be negative if loss
        #puts "home elo: #{home_elo}"
        #puts "away elo: #{away_elo}"
        #puts "gd: #{gd}"
        
        if gd > 0
            #won
            change = 8 * 1 * elo_margin(home_elo,away_elo,gd) * (1 - prop_elo(home_elo,away_elo) )
        elsif gd < 0
            #loss
            change = 8 * 1 * elo_margin(home_elo,away_elo,gd) * (0 - prop_elo(home_elo,away_elo) )
        else
            #tie
            change = 8 * 1 * elo_margin(home_elo,away_elo,gd) * (0.5 - prop_elo(home_elo,away_elo) )
        end
        
        #change = 8 * 1 * elo_margin(home_elo,away_elo,gd) * (won - prop_elo(home_elo,away_elo) )
        change = change.round
        #puts change
    end


    def elo_margin(home_elo,away_elo,goal_diff)
        
        
        elo_prop = (home_elo - away_elo) + HOME_ADV
        
        #puts elo_prop
        
        elo_prop = elo_prop.to_f / 100
        
        #puts elo_prop
        
        #suppose to be goal diff * 0.85
        
        elo_prop = elo_prop * 0.85
        
        #puts "time 0.85: #{elo_prop}"
        
        elo_prop = (goal_diff.to_f) - elo_prop.to_f
        
        #puts "goal diff : #{elo_prop}"
        
        elo_prop = elo_prop.abs
        
        #puts "abs: #{elo_prop}"
        
        elo_prop = Math.log(elo_prop + Math::E - 1)
        
        #puts "log: #{elo_prop}"
        
        if elo_prop >= -1 && elo_prop <= 1
            elo_prop = 1
        end
        
        #puts "final: #{elo_prop}"
        return elo_prop
    end

end