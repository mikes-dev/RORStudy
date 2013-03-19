Given /^there is a project called "([^\"]*)"$/ do |name|
	@Project = FactoryGirl.create(:project, :name => name)
end
