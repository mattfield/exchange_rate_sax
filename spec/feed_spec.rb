require "exchange_rate/feed"
require 'ox'
require 'date'

describe Feed do
  before(:all) do
    @test_feed = Feed.new("spec/fixtures/example.xml")
  end

  it "returns a raw feed" do
		expect(@test_feed.raw).to_not be nil
		expect(@test_feed.raw).to be_a String
  end

  it "returns a parsed feed" do
		expect(@test_feed.parsed).to be_a Array
  end
end

describe ECBFeed do
	before(:all) do
		@test_feed = ECBFeed.new("spec/fixtures/example.xml")
	end

	context "ECBFeed" do
		it "should be a subclass of Feed" do
			expect(@test_feed).to be_a Feed
		end

		it "should return a raw feed from a file path" do
			expect(@test_feed.raw).to be_a String
		end
	end

	context "ECBFeed#get_dates" do
		it "should return a list of dates" do
			expect(@test_feed.get_dates).to be_a Array
		end

		it "should return a parseable date format" do
			expect(Date.parse(@test_feed.get_dates[0])).to be_a Date
		end
	end

	context "ECBFeed#group_by_date" do
		it "should return a list of dates" do
			@test_feed.group_by_date
			#expect(@test_feed.group_by_date).to be_a Array
		end
	end
end
