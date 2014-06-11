require 'spec_helper'

describe UnifyCount::ItunesAdapter do
	before(:each) do
		@adapter = UnifyCount::ItunesAdapter.new('plist.xml')
	end

	context 'reading the metadata' do
	  it 'reads all the songs' do
	  	result = @adapter.all
	  	expect(result).to have(2).items
  	end

  	specify 'every file has play count' do
  		@adapter.all.each do |song|
  			expect(song[:playCount]).to be_an Integer
  		end
  	end

  	specify 'every file has uri' do
  		@adapter.all.each do |song|  			
  			expect(song[:uri]).to be_a String
  		end
  	end

    specify 'every file has a key' do
      @adapter.all.each do |song|
        expect(song[:key]).to be_a String
      end
    end
  end

  context 'finding songs' do
    it 'finds by uri' do
      song = @adapter.find_by_uri('another/file.mp3')
      # raise Exception, song.inspect
      expect(song[:playCount]).to eql(20)
    end

    it 'finds by key' do
      song = @adapter.find_by_key(2)
      expect(song[:uri]).to eql('another/file.mp3')
    end
  end

  context 'updating songs' do
    after(:each) do
      @adapter.update_song(@adapter.find_by_key(1),
        playCount: 10)
    end

    it 'updates the play count' do
      song = @adapter.find_by_key(1)
      @adapter.update_song(song, playCount: 100)
      @adapter.reload_songs
      song = @adapter.find_by_key(1)
      expect(song[:playCount]).to eql(100)
    end
  end

end
