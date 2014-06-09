require 'spec_helper'
describe 'Version' do
	it "shows the Version" do
		expect(UnifyCount::VERSION).to_not be_nil
	end
end
