# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

#create all the league objects
omha = League.create(name: "OMHA")
gthl = League.create(name: "GTHL")
alliance = League.create(name: "Alliance")

class Stuff
	def initialize
	
		@home_score = 0
		@home_team = 0
		@away_score = 0
		@away_team = 0
		@time = Time.now
		
	end
	
	def initialize(time,date, venue, home_team, away_team , home_score, away_score)
		@home_score = home_score
		@away_score = away_score
		@home_score = home_score
		@home_team = home_team
		@away_team = away_team
		#puts "#{time} #{date} #{venue}"
		@time = DateTime.strptime("#{time} #{date}", '%b %d %I:%M %p')
		
		
		#time_split = time
		#day = date
		#puts time_split
		#puts day
		#may be causing problems because timesplit is Sep 11 and expecting Sep
		#if Date::ABBR_MONTHNAMES.index(time_split.to_s) >= 1 && Date::ABBR_MONTHNAMES.index(time_split.to_s) <= 4
			
		#	@time = DateTime.strptime("#{time_split} #{day}", '%b %d %I:%M %p')
		#else
			
		#	@time = DateTime.strptime("#{time_split} #{day}", '%b %d %I:%M %p')
		#end
		
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

files = Dir.entries("./db/game_data")
listOfGames = []
files.each do | x |
    puts x
	name = x.match(".*\.\(csv\)")
	unless name.nil?
		#puts name
		listOfGames << name
	end
end

theGames = []
teamNames = []
#need to rest the games and teams names each time
listOfGames.each do | x |
	stuff = x.to_s.split('-')
	if stuff[0] == 'OMHA'
		
		if stuff[1] == 'AAA'
			
			if stuff[2] == 'Novice'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					derp = stuff[3].split('.')
					
					puts stuff[2]
					puts stuff[1]
					puts derp[0]
					
					tmp = Season.create(age_group: stuff[2].to_s, skill_level: stuff[1].to_s, year: derp[0], league: omha)
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, season: tmp)
					end
					
					theGames.each do | b |
						#have to be more specific and have to select by age group, skill_level, league, year,
					    #home = Team.find_by( team_name: b.home_team, season: tmp)
					    home = Team.find_by( team_name: b.home_team)
					    #away = Team.find_by( team_name: b.away_team, season: tmp)
					    away = Team.find_by( team_name: b.away_team)
					    
					    Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
					
					#create games here
				end
			elsif stuff[2] == 'Minor_Atom'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						#puts game.print
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, skill_level: aaa , league: omha, year: a2016, age_group: mat)
					end
					
					theGames.each do | b |
					    home = Team.find_by( team_name: b.home_team, skill_level: aaa, league: omha, age_group: mat)
					    away = Team.find_by( team_name: b.away_team, skill_level: aaa, league: omha, age_group: mat)
					    
					   Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
				end
			elsif stuff[2] == 'Atom'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, skill_level: aaa , league: omha, year: a2016, age_group: atm)
					end
					
					theGames.each do | b |
					    home = Team.find_by( team_name: b.home_team, skill_level: aaa, league: omha, age_group: atm)
					    away = Team.find_by( team_name: b.away_team, skill_level: aaa, league: omha, age_group: atm)
					    
					   Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
				end
			elsif stuff[2] == 'Minor_Peewee'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, skill_level: aaa , league: omha, year: a2016, age_group: mpw)
					end
					
					theGames.each do | b |
					    home = Team.find_by( team_name: b.home_team, skill_level: aaa, league: omha, age_group: mpw)
					    away = Team.find_by( team_name: b.away_team, skill_level: aaa, league: omha, age_group: mpw)
					    
					   Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
				end
			elsif stuff[2] == 'Peewee'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, skill_level: aaa , league: omha, year: a2016, age_group: pwe)
					end
					
					theGames.each do | b |
					    home = Team.find_by( team_name: b.home_team, skill_level: aaa, league: omha, age_group: pwe, year: a2016)
					    away = Team.find_by( team_name: b.away_team, skill_level: aaa, league: omha, age_group: pwe, year: a2016)
					    
					   Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
				end
			elsif stuff[2] == 'Minor_Bantam'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, skill_level: aaa , league: omha, year: a2016, age_group: mbn)
					end
					
					theGames.each do | b |
					    home = Team.find_by( team_name: b.home_team, skill_level: aaa, league: omha, age_group: mbn)
					    away = Team.find_by( team_name: b.away_team, skill_level: aaa, league: omha, age_group: mbn)
					    
					    Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
				end
			elsif stuff[2] == 'Bantam'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, skill_level: aaa , league: omha, year: a2016, age_group: btm)
					end
					
					theGames.each do | b |
					    home = Team.find_by( team_name: b.home_team, skill_level: aaa, league: omha, age_group: btm)
					    away = Team.find_by( team_name: b.away_team, skill_level: aaa, league: omha, age_group: btm)
					    
					   Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
				end
			elsif stuff[2] == 'Minor_Midget'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, skill_level: aaa , league: omha, year: a2016, age_group: mmd)
					end
					
					theGames.each do | b |
					    home = Team.find_by( team_name: b.home_team, skill_level: aaa, league: omha, age_group: mmd)
					    away = Team.find_by( team_name: b.away_team, skill_level: aaa, league: omha, age_group: mmd)
					    
					   Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
				end
			elsif stuff[2] == 'Midget'
				if stuff[3].include? "2016"
					#puts stuff[3]
					CSV.foreach("./db/game_data/" + x.to_s) do |row|
						# use row here...
						#puts row
						game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
						theGames << game
					end
					theGames.each do | y |
						teamNames << y.away_team
						teamNames << y.home_team
						teamNames = teamNames.uniq
					end
					
					teamNames.each do | z |
						#create teams here
						puts z
						Team.create(team_name: z.to_s, skill_level: aaa , league: omha, year: a2016, age_group: mgt)
					end
					
					theGames.each do | b |
					    home = Team.find_by( team_name: b.home_team, skill_level: aaa, league: omha, age_group: mgt)
					    away = Team.find_by( team_name: b.away_team, skill_level: aaa, league: omha, age_group: mgt)
					    
					   Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
					end
				end
			end
		elsif stuff[1] == 'AA'
			puts stuff[1]
		elsif stuff[1] == 'A'
			puts stuff[1]
		end
	elsif stuff[1] == 'Alliance'
		
	elsif stuff[2] == 'GTHL'
		
	end
	
	theGames = []
	teamNames = []
end