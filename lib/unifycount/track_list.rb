require 'ruby-progressbar'
module UnifyCount
	class TrackList
		
		def initialize(adapter)
			@songs = adapter
		end
		
		def update_with(track_list)
      updates = 0
      pb = ProgressBar.create(
        :title => "Songs",
        :total => @songs.size,
        :format => '%a |%b>>%i| %p%% %t'
      )
			@songs.all.each do |my_song|
        # binding.pry
        pb.log "Updating #{my_song[:uri].gsub('%20',' ')}..."
				if track_list.contains?(my_song)
          updates += 1
					his_song = track_list.find_song(my_song)
					my_play_count = my_song[:playCount]
					his_play_count = his_song[:playCount]
					track_list.update_song(his_song, playCount: 0)
					self.update_song(my_song, playCount: his_play_count + my_play_count)
				end
        pb.increment
			end
      pb.log "#{@songs.size} analyzed, #{updates} songs updated"
		end

		def new_play_count(song)
			find_song(song)[:playCount] + song[playCount]
		end

		def update_song(song, args={})
			@songs.update_song(song,args)
		end

		def contains?(song)
			@songs.find_by_uri(song[:uri])
		end

    def save
      @songs.save
    end
		alias_method :find_song, :contains?
	end

end
