module ApplicationHelper
    #first argument is coloumn name and the second arguemnt is if you want a speific name or refer to colomun
    def sortable(column, title = nil)
        title ||= column.titleize
        css_class = (column == sort_column) ? "current #{sort_direction}" : nil
        direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
        link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end
    
    def goal_diff(diff)
        if diff >= 0
            "<span id=\"positive\"> #{diff} </span>"
        else
            "<span id=\"negative\"> #{diff} </span>"
        end
    end
    
    def points(wins,ties)
       (wins * 2) + ties 
    end
    
    def gp(wins,loses,ties)
        wins + loses + ties
    end
    
    def diff(gf, ga)
        gf - ga
    end
    
end
