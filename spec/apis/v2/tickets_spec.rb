require 'spec_helper'
include Devise::TestHelpers

describe "/api/v2/tickets", :type => :api do

	let(:project) { FactoryGirl.create(:project, :name => "Ticketee") }

	context "index" do

		before do
			5.times do
				FactoryGirl.create(:ticket, :project => project, :user => @user)
			end
		end

		let(:url) { "/api/v2/projects/#{project.id}/tickets" }
			
			it "XML" do
				get "#{url}.xml", :token => token
				last_response.body.should eql(project.tickets.to_xml)
			end
			
			it "JSON" do
				get "#{url}.json", :token => token
				last_response.body.should eql(project.tickets.to_json)
			end

	end

	before do
		@user = create_user!
		@user.update_attribute(:admin, true)
		@user.permissions.create!(:action => "view",
									:thing => project)
	end

	let(:token) { @user.authentication_token }
end