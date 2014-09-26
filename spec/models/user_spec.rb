require 'spec_helper'

describe 'Users' do

	let(:user1) { FactoryGirl.create(:user, company: "abc") }
	let(:user2) { FactoryGirl.create(:user, company: "zxc") }
	
	describe "#company_info" do

		it "should return a nested array of companies sorted alphabetically" do
			Rails.cache.write('users_info', { user1.company => [user1], user2.company => [user2]})
			expect(User.company_info[0][0]).to eq("abc")
			expect(User.company_info[1][0]).to eq("zxc")
		end
	end

	describe "#metadata" do
		let(:results) { User.metadata("abc") }

		it "should accept a company name and return a hash with most common_browser and common_os" do
			Rails.cache.write('users_info', { user1.company => [user1], user2.company => [user2]})
			expect(results[:common_browser]).to be_a(String)
			expect(results[:common_os]).to be_a(String)
		end
	end
end