class ProjectsController < ApplicationController
	def index
		@projects = Project.all
	end

	def new
		@Project = Project.new
	end
	
	def create
		@Project = Project.new(params[:project])
		if @Project.save			 
			flash[:notice] = "Project has been created."
			redirect_to @Project
		else
			flash[:alert] = "Project has not been created."
			render :action => "new"
		end
	end

	def show
		@Project = Project.find(params[:id])
	end
	
	def edit
		@Project = Project.find(params[:id])
	end

	def update
		@Project = Project.find(params[:id])
		if @Project.update_attributes(params[:project])
			flash[:notice] = "Project has been updated."
			redirect_to @Project
		else
			flash[:alert] = "Project has not been updated."
			render :action => "edit"
		end
	end



end
