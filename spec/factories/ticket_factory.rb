FactoryGirl.define do	
	factory :ticket do |ticket|
			ticket.title "A ticket"
			ticket.description "A ticket, nothing more"
			ticket.user { |u| u.association(:user) }
			ticket.project { |p| p.association(:project) }
	end
end














#FactoryGirl.define do	
#	factory :user do |user|
#			user.name 'TestAdmin'
#	end
#end