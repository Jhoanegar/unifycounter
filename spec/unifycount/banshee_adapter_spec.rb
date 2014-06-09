require 'spec_helper'
require 'sqlite3'

def create_test_database
	file = 'testdb.sqlite3'
	File.delete(file) if File.file?(file)
	db = SQLite3::Database.new(file)
	db.execute('CREATE TABLE CoreTracks(
		uri VARCHAR, playcount INT);')
	db.execute("INSERT INTO CoreTracks 
			VALUES('file:///path/to/file.mp3',10);")
	db.execute("INSERT INTO CoreTracks 
			VALUES('file:///another/file.mp3',20);")	
end

describe UnifyCount::BansheeAdapter do
	before(:all) do
		create_test_database
	end

	after(:all) do
		file = 'testdb.sqlite3'
		File.delete(file) if File.file?(file)
	end

	before(:each) do
		@adapter = UnifyCount::BansheeAdapter.new('testdb.sqlite3')
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

  end

end