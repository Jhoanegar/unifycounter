require 'spec_helper'

describe UnifyCount::TrackList do
	before(:each) do
		adapter = double('adapter')
		adapter.stub(:all) { {
			uri: 'file:///path/to/file.mp3',
			key: 1,
			playCount: 10}
		}
		@itunesAdapter = adapter
		adapter = double()
		adapter.stub(:all) { {
			uri: 'file:///path/to/file.mp3',
			key: 4234,
			playCount: 4}
		}
		@bansheeAdapter = adapter
	end

	# it 'updates correctly' do
	# 	track_list = UnifyCount::TrackList.new(@itunesAdapter)
	# 	before_play_count = track_list[0]['playCount']
	# 	banshee_track_list = UnifyCount::TrackList.new(@bansheeAdapter)
	# 	track_list.update_with(banshee_track_list)
	# 	after_play_count = track_list[0]['playCount']
	# 	expect(after_play_count).to be >= before_play_count
	# end


end