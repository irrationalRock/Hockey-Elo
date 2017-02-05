# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#had to rename because it was creating conflicts with the game table
class Stuff
	def initialize
	
		@home_score = 0
		@home_team = 0
		@away_score = 0
		@away_team = 0
		@time = Time.now
		
	end
	
	def initialize(time,date, score, away_team, home_team,venue)
		@home_score = home_score
		@score = score
		@away_score = score.split("-").first.strip
		@home_score = score.split("-").last.strip
		#puts "away_score: #{@away_score}"
		@home_team = home_team.to_s.gsub!(/\d\s?/, "")
		@away_team = away_team.to_s.gsub!(/\d\s?/, "")
		
		time_split = time.to_s.split(" ").first
		day = time.to_s.split(" ").last
		#puts "time : #{ time_split} "
		#derp = Date::ABBR_MONTHNAMES.index(time_split.to_s)
		#puts "derp : #{derp}"
		#puts "trans : #{ Date::ABBR_MONTHNAMES.index(time_split.to_s) } "
		if Date::ABBR_MONTHNAMES.index(time_split.to_s) >= 1 && Date::ABBR_MONTHNAMES.index(time_split.to_s) <= 4
			#puts "2016 #{time_split} #{day} #{date}"
			@time = DateTime.strptime("2016 #{time_split} #{day} #{date}", '%Y %b %d %I:%M %p')
		else
			#puts "2015 #{time_split} #{day} #{date}"
			@time = DateTime.strptime("2015 #{time_split} #{day} #{date}", '%Y %b %d %I:%M %p')
		end
		
		#@time = time
		@venue = venue
	end
	
	def home_score
	    @home_score
	end
	
	def home_team
	    @home_team
	end
	
	def away_score
	    @away_score
	end
	
	def away_team
	    @away_team
	end
	
	def time
		@time
	end
	
	def venue
		@venue
	end
	
	def eql?(other)
    	if @home_team.eql?(other.home_team) && @away_team.eql?(other.away_team) && @time.eql?(other.time)
    		return true
    	end
    	return false
	end
	
	def print
		puts " home id : #{@home_team} score : #{@home_score} - #{@away_score} away id: #{@away_team}  date: #{@time} venue: #{@venue}"
	end
end

class Hockey_Scraper
    attr_reader :url, :doc, :games
    
    
    def initialize(url)
        @url = url
        @doc = Nokogiri::HTML(open(url))
        @games = []
        table = doc.at('#page_body > section > table')

        game_stats = ""
        table.search('tr').each do |tr|
    
            tr.search('td').each do |td|
                if (td['class'] != 'hide-wide date-and-time')
                    #puts td.text
                    game_stats << td.text.strip << ","
                end
    
            end
            
            @games << remove_trailing_comma(game_stats)
            game_stats = ""
            
        end
	
		
		@games.shift
		
        @games.each_with_index do |val, index|
         puts "#{index} : #{val}"
        end
        
        #game_list.shift
        
    end
    
    
    def game_return 
        game_list = []
        @games.each do |x|
        	puts x
        	game_sheet = x.split(",")
        	
        	
        	game_sheet.each_with_index do |val, index|
        		#puts "#{index} : #{val}"
        	end
        	
        	if game_sheet[4] != ""
            	game_list.push(Stuff.new(game_sheet[1],game_sheet[2],game_sheet[4],game_sheet[3],game_sheet[5], game_sheet[6]))
            	end
            
        end
        #puts "games length : #{@games.length}"
        #puts "game_list : #{game_list.length}"
        
        
        game_list.each_with_index do |val, index|
        		#puts "#{index} : #{val.print}"
        end
        
        return game_list
    end
    
    def remove_trailing_comma(str)
    str.nil? ? nil : str.chomp(",")
    
    end
end

def rand_time(from, to=Time.now)
	Time.at((to.to_f - from.to_f)*rand + from.to_f)
end

team_seasons = ["http://www.theonedb.com/Teams/27732/Peterborough-ETA-Bantam-Petes-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27680/Central-Ontario-ETA-Bantam-Wolves-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27741/Quinte-ETA-Bantam-Red-Devils-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27697/Kingston-ETA-Bantam-Jr-Frontenacs-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27759/Whitby-ETA-Bantam-Wildcats-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27689/Clarington-ETA-Bantam-Toros-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27723/Oshawa-ETA-Bantam-Generals-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27768/York-Simcoe-ETA-Bantam-Express-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27671/Barrie-ETA-Bantam-Jr-Colts-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27714/North-Central-ETA-Bantam-Predators-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27750/Richmond-Hill-ETA-Bantam-Coyotes-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27662/Ajax-Pickering-ETA-Bantam-Raiders-2016-2017/Schedule",
"http://www.theonedb.com/Teams/27706/Markham-ETA-Bantam-Waxers-2016-2017/Schedule"]

teams = ['Markham Waxers','York-Simcoe Express', 'Barrie Jr Colts', 'North Central Predators', 'Richmond Hill Coyotes', 
'Ajax-Pickering Raiders', 'Peterborough Petes', 'Central Ontario Wolves', 'Quinte Red Devils', 'Kingston Jr Frontenacs', 
'Whitby Wildcats', 'Clarington Toros', 'Oshawa Generals' ]

location = ['Markham', 'Newmarket', 'Barrie', 'Orillia', 'Richmond Hill', 
'Ajax-Pickering', 'Peterborough', 'Lindsay', 'Quinte', 'Kingston', "Whitby", "Clarington", "Oshawa" ]

#seeding the teams
Team.create(team_name: teams[0], location: location[0], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[1], location: location[1], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[2], location: location[2], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[3], location: location[3], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[4], location: location[4], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[5], location: location[5], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[6], location: location[6], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[7], location: location[7], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[8], location: location[8], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[9], location: location[9], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[10], location: location[10], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[11], location: location[11], skill_level: 'AAA', age_group: 'Bantam')

Team.create(team_name: teams[12], location: location[12], skill_level: 'AAA', age_group: 'Bantam')

#home_teams = (1..13).to_a
#away_teams = (1..13).to_a

#puts home_teams
#puts away_teams

master_list = []

team_seasons.each do | x |
	teams_game = Hockey_Scraper.new(x)
	master_list = master_list + teams_game.game_return
	master_list = master_list.uniq{ |u|
    	uniq_array = [u.home_team, u.away_team, u.time]
    	uniq_array
	}
	#master_list = (master_list | teams_game.game_return).uniq
end

master_list.sort! { |x, y|
	x.time <=> y.time
	
}

puts "after hockey scrap"

master_list.each do | i |
	i.print
	home_conv = teams.find_index(i.home_team) + 1
	away_conv = teams.find_index(i.away_team) + 1
	Game.create(home_team_id: home_conv, away_team_id: away_conv, home_team_score: i.home_score, away_team_score: i.away_score, date: i.time, venue: i.venue)
end

puts "master_list length: #{master_list.length}"

=begin

game_list = []

home_teams.each do |x|
    array_copy = away_teams
    array_copy.each do |i|
		if x != i
			2.times do |y|
			    game = Stuff.new(rand(0..10), rand(0..10), x, i,rand_time(Time.local(2015,9,18), Time.local(2016,4,1) ) )
			    #Game.new(rand(0..10), rand(0..10), rand(1..13), rand(1..13),rand_time(Time.local(2015,9,18), Time.local(2016,4,1) ) )
			    #Game.new(home_team_id: 1, away_team_id: 4, away_team_score: 1 , home_team_score: 5, date:Time.now )
			    game_list.push(game)
			    
			    #Game.create(home_team_id: x, away_team_id: i,home_team_score: rand(0..10), away_team_score: rand(0..10), date: rand_time(Time.local(2015,9,18), Time.local(2016,4,1) ) )
				
			end
					
		end
        
    end
    
        
    #end
end
=end

#game_list = game_list.sort do |x, y|
#	x.time <=> y.time
#end


#game_list.each do |x|
#    Game.create(home_team_id: x.home_team, away_team_id: x.away_team, home_team_score: x.home_score, away_team_score: x.away_score, date: x.time, venue: "")
#end

#rake db:seeds
#make sure to reset database to include the reset of the teams