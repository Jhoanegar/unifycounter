# require 'spec_helper'

# describe UnifyCount::TrackList do
# 	before(:each) do
# 		adapter = double()
# 		adatper.stub(:all) { ['file:///path/to/file.mp3']}
# 	end
# 	context 'retrieving songs' do
# 		it 'finds a song given the uri' do
# 			song = @adapter.find_by_uri('file:///path/to/file.mp3')
# 			expect(song[:playCount]).to eql(10)
# 		end
# 	end
# end