require 'spec_helper'
require 'sqlite3'

def create_test_database
	file = 'testdb.sqlite3'
	File.delete(file) if File.file?(file)
	db = SQLite3::Database.new(file)
	db.execute('CREATE TABLE CoreTracks(
		uri VARCHAR, playcount INT, trackID INT);')
	db.execute("INSERT INTO CoreTracks 
			VALUES('file:///path/to/file.mp3',10,1);")
	db.execute("INSERT INTO CoreTracks 
			VALUES('file:///another/file.mp3',20,2);")	
end

describe UnifyCount::BansheeAdapter do

	before(:each) do
		create_test_database
		@adapter = UnifyCount::BansheeAdapter.new('testdb.sqlite3')
	end

	after(:each) do
		file = 'testdb.sqlite3'
		File.delete(file) if File.file?(file)
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
  			expect(song[:key]).to be_a Integer
  		end
  	end
  end

  context 'finding songs' do
  	it 'finds by uri' do
  		song = @adapter.find_by_uri('file:///another/file.mp3')
  		expect(song[:playCount]).to eql(20)
  	end

  	it 'finds by key' do
  		song = @adapter.find_by_key(2)
  		expect(song[:uri]).to eql('file:///another/file.mp3')
  	end
  end

  context 'updating songs' do
		it 'updates the play count' do
			song = @adapter.find_by_key(1)
			@adapter.update_song(song, playCount: 100)
			@adapter.reload_songs
			song = @adapter.find_by_key(1)
			expect(song[:playCount]).to eql(100)
		end
  end
 end