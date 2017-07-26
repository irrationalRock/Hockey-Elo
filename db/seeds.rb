# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

#create all the league objects
#change to a hash
omha = League.create(name: "OMHA")
gthl = League.create(name: "GTHL")
alliance = League.create(name: "Alliance")

leagues = { "omha" => omha, "gthl" => gthl, "alliance" => alliance}

files = Dir.entries("./db/game_data")
listOfGames = []
files.each do | x |
    #puts x
	name = x.match(".*\.\(csv\)")
	unless name.nil?
		puts name
		listOfGames << name
	end
end

#combo = Array.new

#listOfGames.each_with_index do | x, index |
#	stuff = x.to_s.split('-')
	#combo = combo.merge( { index => [stuff[1], stuff[2], stuff[3]] } )
#	combo << [stuff[1], stuff[2].sub("_"," "), File.basename(stuff[3], '.csv').to_i]
#end

#combo = combo.uniq

#combo.each do | x |
#	p x
#end

#storeSeasons = Hash.new

#combo.each do | y |
#	s = Season.create(skill_level: y[0], age_group: y[1], year: y[2] )
#	storeSeasons = storeSeasons.merge( "#{y[1][0..1]}#{y[1][6..7]}#{y[2].to_s}" => s )
	
#end



#move class somewhere else
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

#files = Dir.entries("./db/game_data")
#listOfGames = []
#files.each do | x |
#    puts x
#	name = x.match(".*\.\(csv\)")
#	unless name.nil?
		#puts name
#		listOfGames << name
#	end
#end

#p storeSeasons



#listOfGames.each do | x |

#	fileSplit = x.to_s.split('-')
	
#	CSV.foreach("./db/game_data/" + x.to_s) do |row|
		# use row here...
		#puts row
#		game = Stuff.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
#		#puts game.print
#		theGames << game
#	end
	
#	theGames.each do | y |
#		teamNames << y.away_team
#		teamNames << y.home_team
#		teamNames = teamNames.uniq
#	end
#	derp = fileSplit[3].split('.')
		
	#p fileSplit
#	c = Competition.create(season: storeSeasons["#{fileSplit[2][0..1]}#{fileSplit[2][6..7]}#{derp[0]}"], league: leagues[fileSplit[0].downcase] )
#	puts fileSplit[0]
	#puts "#{fileSplit[2][0..1]}#{fileSplit[2][6..7]}#{derp[0]}"
	#p c
	
	#need to first create a competition and then add it to a team
#	teamNames.each do | z |
		#create teams here
#		puts z
#		Team.create(team_name: z.to_s, competition: c)
#	end
	#need to load games
#	theGames.each do | b |
#		home = Team.find_by( team_name: b.home_team, competition: c)
#		away = Team.find_by( team_name: b.away_team, competition: c)
					    
#		Game.create(home_team: home, away_team: away, home_team_score: b.home_score, away_team_score: b.away_score, date: b.time, venue: b.venue) 
#	end
	
#	theGames = []
#	teamNames = []
#end

#################################################################

theGames = []
teamNames = []

combo = Array.new

leagueNames = Array.new

teamCat = Array.new
allSeason = Array.new
stillTesting = Hash.new
p listOfGames
moreTesting = Hash.new
#need to move allocation to outside of csv
listOfGames.each do | x |
	stuff = x.to_s.split("-")
	allSeason << [stuff[0], stuff[2], stuff[3], stuff[4]]
	CSV.foreach("./db/game_data/" + x.to_s) do | f |
		
		#make seperate array for each to put the teams in
		#f.each_line do |line|
			#puts line
			
			#derp = f.split(',')
		p f
		puts "#{f[4]}, #{f[5]}, #{f[0]}"
		if f[0].include? "Oct"
			teamCat << f[4]
			teamCat << f[5]
		end
		#end
		
	end
	teamCat = teamCat.uniq
	zerp = [stuff[0], stuff[2].to_s.sub("_"," "), stuff[3].to_s.sub("_"," "), File.basename(stuff[4], '.csv').to_i]
	#need to allow for adding more teams instead of overriding
	#moreTesting[zerp] = teamCat
	collectTeams = Array.new
	if moreTesting[zerp].nil?
		moreTesting[zerp] = teamCat
	else
		recentTeams = moreTesting[zerp]
		moreTesting[zerp] = recentTeams + teamCat
	end
		#stillTesting.rehash
	
	moreTesting.rehash
	teamCat = []
end

puts "list of games"

allSeason = allSeason.uniq

allGames = Array.new

#need to make changes look at above for reference
listOfGames.each do | x |
	#need to check scope of this to make sure it's correct
	games = Array.new
	CSV.foreach("./db/game_data/" + x.to_s) do | f |
		stuff = x.to_s.split("-")
		#make seperate array for each to put the teams in
		games = Array.new
		p f
		#need to move adding somewhere else
		#f.each_line do |line|
			#puts line
			#derp = line.split(',')
			puts "#{f[0]}, #{f[1]}, #{f[2]}, #{f[2]}, #{f[3]}, #{f[4]}, #{f[5]}, #{f[6]} #{f[7]}"
			games << [f[0], f[1], f[2], f[3], f[4], f[5],f[6], f[7].gsub("\n","")]
			
			
		#end
		#teamCat = teamCat.uniq
		#look into using moreTesting here to get keys instead
		herp = [stuff[0], stuff[2].to_s.sub("_"," "), stuff[3].to_s.sub("_"," "), File.basename(stuff[4], '.csv').to_i]
		#p herp
		#p games
		recentGames = Array.new
		if stillTesting[herp].nil?
			stillTesting[herp] = games
		else
			recentGames = stillTesting[herp]
			stillTesting[herp] = recentGames + games
		end
		stillTesting.rehash
		
		#zerp = [stuff[0], stuff[2].to_s.sub("_"," "), stuff[3].to_s.sub("_"," "), File.basename(stuff[4], '.csv').to_i]
		#p zerp
		#allSeason[zerp] = games
		#allSeason.rehash
		#games = []
	end
end


#good to go. need to test games now
#need to test for duplicate games and get ride of games that are not in teams list
stillTesting.each_pair { | key, value |
	listOfTeams = Array.new
	#p key
	puts "old #{value.length}"
	value = value.uniq
	puts "new #{value.length}"
	#p key
	altKey = key
	fillTeams = []
	moreTesting.each_pair { | key, value |
		
		newArray = [key[0],key[1], key[2],key[3]]
		puts "newArray"
		#p key
		#puts "is equal? #{newArray <=> altKey}"
		if (newArray <=> altKey) == 0 
			puts "match"
			fillTeams += value
			fillTeams.flatten
		end		
		#p fillTeams
		#p key
	}
	#need to remove teams and need to investigate more
	#puts "fill teams"
	#p fillTeams
	value = value.select { |f| 
		#p f
		#4,5 in array
		(fillTeams.include? f[4]) && (fillTeams.include? f[5])
	}
	puts "final: #{value.length}"
	
	#need this to reset 
	stillTesting[key] = value
	 
}

stillTesting.each_pair { | key, value |
	p key
	puts "recollect: #{value.length}"
}

puts "*" * 40
p moreTesting
puts "#" * 40

storeSeasons = Hash.new

stillTesting.each_pair { | key, value |
	p key
	if Season.find_by(skill_level: "#{key[1]}" , age_group: "#{key[2]}", year: "#{key[3]}") == nil
		s = Season.create(skill_level: "#{key[1]}" , age_group: "#{key[2]}", year: "#{key[3]}")
		storeSeasons = storeSeasons.merge( "#{key[2][0..1]}#{key[2][6..7]}#{key[3].to_s}#{key[1]}" => s )
	end
}

p storeSeasons

storeCompetition = Hash.new

moreTesting.each_pair { | key, value |
	
	#p key
	#c = Competition.create(season: storeSeasons["#{key[3][0..1]}#{key[3][6..7]}#{key[4].to_s}#{key[2]}"], division: storeDivisons["#{key[1]}#{key[0]}"])
	#need to store all of competitions in hash
	c = Competition.create(season: storeSeasons["#{key[2][0..1]}#{key[2][6..7]}#{key[3]}#{key[1]}"], league: leagues[key[0].downcase] )
	storeCompetition = storeCompetition.merge("#{key[0]}#{key[2][0..1]}#{key[2][6..7]}#{key[3]}#{key[1]}" => c )
	
	#puts c
	
	#need to first create a competition and then add it to a team
	value.each do | z |
		#create teams here
		#puts z
		Team.create(team_name: z.to_s, competition: c)
	end

}

#p storeCompetition

stillTesting.each_pair do | key, value |
	#check to see if competiton match with games list 
	value.each do | x |
		p x	
		home = Team.find_by( team_name: x[4], competition: storeCompetition["#{key[0]}#{key[2][0..1]}#{key[2][6..7]}#{key[3]}#{key[1]}"])
		away = Team.find_by( team_name: x[5], competition: storeCompetition["#{key[0]}#{key[2][0..1]}#{key[2][6..7]}#{key[3]}#{key[1]}"])
		
		#puts home 
		
		#account for leap year
		Game.create(home_team: home, away_team: away, home_team_score: x[6], away_team_score: x[7], date: DateTime.strptime("#{x[0]} #{x[1]} #{x[2]}", '%b %d %I:%M %p %Y'), venue: x[3]) 
	end
end