require 'sqlite3'
module UnifyCount
	class BansheeAdapter
		attr_reader :db

		def initialize(file)
			@db = SQLite3::Database.open(file)
			@songs = []
		end

		def all
			return @songs unless @songs.empty?
			@db.execute('SELECT uri,playCount FROM CoreTracks;').each do |row|
				@songs << { uri: row[0].gsub(/file.*media\//,''), playCount: row[1]} 	
			end
			return @songs
		end
	end

end