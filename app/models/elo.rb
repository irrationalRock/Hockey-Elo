module ELO
    #how much advantage home teams should have
    HOME_ADV = 50
    
    #evaluates the elo propbabity of the home elo winning 
    def prop_elo(home_elo,away_elo)
        
        elo_prop = (home_elo - away_elo) + HOME_ADV
        
        elo_prop = -elo_prop.to_f / 400.to_f
        
        elo_prop = 10 ** elo_prop.to_f
        
        elo_prop = elo_prop + 1
        
        elo_prop = 1 / elo_prop.to_f
            
        return elo_prop
    end


    #calulates the change in elo
    def elo_change(home_elo,away_elo,gd)
        
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
        
        change = change.round
    end


    def elo_margin(home_elo,away_elo,goal_diff)
        
        
        elo_prop = (home_elo - away_elo) + HOME_ADV
        
        
        elo_prop = elo_prop.to_f / 100
        
        elo_prop = elo_prop * 0.85
        
        elo_prop = (goal_diff.to_f) - elo_prop.to_f
        
        elo_prop = elo_prop.abs
        
        elo_prop = Math.log(elo_prop + Math::E - 1)
        
        if elo_prop >= -1 && elo_prop <= 1
            elo_prop = 1
        end
        
        return elo_prop
    end

end