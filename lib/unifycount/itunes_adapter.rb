require 'plist'
module UnifyCount
	class ItunesAdapter
		def initialize(file)
			@db = Plist::parse_xml(file)
			@songs = []
		end
	
		def all
			return @songs unless @songs.empty?
			@db['Tracks'].each do |key, track|
				song = {}
				song[:uri] = extract_uri(track)
				song[:playCount] = extract_play_count(track)
				song[:key] = key
				@songs << song
			end
			@songs
		end

		def extract_uri(track)
			track['Location'].gsub(/file.*Music\//,'')
		end

		def extract_play_count(track)
			track['Play Count']
		end

		def find_by_uri(uri)
			ret = all.select { |song| song[:uri] == uri }
			return ret.first unless ret.nil?
			nil
		end

		def find_by_key(key)
			ret = all.select { |song| song[:key].to_s == key.to_s }
			return ret.first unless ret.nil?
			nil
		end

		def reload_songs
			@songs = []
			all
		end

		def update_song(song, args={})
			@db['Tracks'][song[:key]]['Play Count'] = 
				args[:playCount]
		end
	end
end