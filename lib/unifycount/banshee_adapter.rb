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
			@db.execute('SELECT uri,playCount,trackID FROM CoreTracks;').each do |row|
				@songs << { 
					uri: row[0].gsub(/file.*Music\//,''),
					playCount: row[1],
					key: row[2]
				} 	
			end
			return @songs
		end

		def find_by_uri(uri)
			ret = self.all.find { |song| song[:uri] == uri}
			return ret unless ret.nil?
			nil
		end

		def find_by_key(key)
			ret = self.all.find { |song| song[:key] == key}
			return ret unless ret.nil?
			nil
		end

		def update_song(song, args={})
			@db.execute("
				UPDATE CoreTracks 
					SET playCount=#{args[:playCount]}
					WHERE trackID=#{song[:key]};
			")
		end 

		def reload_songs
			@songs = []
			all
		end
	end 
end
