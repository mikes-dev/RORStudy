class ProjectsController < ApplicationController

	before_filter :find_project, :only => [:show,
											:edit,
											:update,
										    :destroy]

	before_filter :authorize_admin!, :except => [:index, :show]
	before_filter :authenticate_user!, :only => [:index, :show]
	before_filter :find_project, :only => [:show, :edit, :update, :destroy]


	def index
		@projects = Project.for(current_user).all
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

	def destroy
		@Project = Project.find(params[:id])
		@Project.destroy
		flash[:notice] = "Project has been deleted."
		redirect_to projects_path
	end

	private
		def find_project
			@Project = if current_user.admin?
				Project.find(params[:id])
			else
				Project.readable_by(current_user).find(params[:id])
			end
			rescue ActiveRecord::RecordNotFound
			flash[:alert] = "The project you were looking" +
			" for could not be found."
			redirect_to projects_path
		end


end
