module ApplicationHelper
    #first argument is coloumn name and the second arguemnt is if you want a speific name or refer to colomun
    def sortable(column, title = nil)
        title ||= column.titleize
        css_class = (column == sort_column) ? "current #{sort_direction}" : nil
        direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
        link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end
    
    def goal_diff(diff)
        if diff > 0
            content_tag(:span, "+" + diff.to_s, class: "positive")
        elsif diff == 0
            content_tag(:span, diff, class: "equal")
        else
            content_tag(:span, diff, class: "negative")
        end
    end
    
    def points(wins,ties)
       (wins * 2) + ties 
    end
    
    def gp(wins,loses,ties)
        wins + loses + ties
    end
    
    def diff(gf, ga)
        goal_diff( gf - ga )
    end
    
end
