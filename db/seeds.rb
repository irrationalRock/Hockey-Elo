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
	
	def initialize(home_score, away_score, home_team, away_team, time)
		@home_score = home_score
		@home_team = home_team
		@away_score = away_score
		@away_team = away_team
		@time = time
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
	
	def print
		puts " home id : #{@home_team}  #{@home_score} - #{@away_score} away id: #{@away_team} date: #{@time}"
	end
end

def rand_time(from, to=Time.now)
	Time.at((to.to_f - from.to_f)*rand + from.to_f)
end

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

home_teams = (1..13).to_a
away_teams = (1..13).to_a

puts home_teams
puts away_teams

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

game_list = game_list.sort do |x, y|
	x.time <=> y.time
end


game_list.each do |x|
    Game.create(home_team_id: x.home_team, away_team_id: x.away_team, home_team_score: x.home_score, away_team_score: x.away_score, date: x.time)
end

#rake db:seeds
#make sure to reset database to include the reset of the teams