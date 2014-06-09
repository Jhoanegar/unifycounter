require 'plist'
module UnifyCount
	class ItunesAdapter
		def initialize(file)
			@bd = Plist::parse_xml(file)
			@songs = []
		end
	
		def all
			return @songs unless @songs.empty?
			@bd['Tracks'].each do |key, track|
				song = {}
				song[:uri] = extract_uri(track)
				song[:playCount] = extract_play_count(track)
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

	end
end