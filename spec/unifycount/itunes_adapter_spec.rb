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

  end

end