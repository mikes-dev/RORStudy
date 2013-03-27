class TicketsController < ApplicationController
	
	before_filter :authenticate_user!

	before_filter :find_project

	before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]

	before_filter :authorize_create!, :only => [:new, :create]

	before_filter :authorize_update!, :only => [:edit, :update]

	before_filter :authorize_delete!, :only => [:destroy]


	def new
		@ticket = @Project.tickets.build
	end

	def create
		@ticket = @Project.tickets.build(params[:ticket].merge!(:user => current_user))
		if @ticket.save
			flash[:notice] = "Ticket has been created."
			redirect_to [@Project, @ticket]
		else
			flash[:alert] = "Ticket has not been created."
			render :action => "new"
		end
	end

	def show
	end

	def edit
	end


	def update
		if @ticket.update_attributes(params[:ticket])
			flash[:notice] = "Ticket has been updated."
			redirect_to [@Project, @ticket]
		else
			flash[:alert] = "Ticket has not been updated."
			render :action => "edit"
		end
	end

	def destroy
		@ticket.destroy
		flash[:notice] = "Ticket has been deleted."
		redirect_to @Project
	end



	private
		def find_project
			@Project = Project.for(current_user).find(params[:project_id])
			rescue ActiveRecord::RecordNotFound
				flash[:alert] = "The project you were looking for could not be found."
				redirect_to root_path
		end

		def find_ticket
			@ticket = @Project.tickets.find(params[:id])
		end

		def authorize_create!
			if !current_user.admin? && cannot?("create tickets".to_sym, @Project)
				flash[:alert] = "You cannot create tickets on this project."
				redirect_to @Project
			end
		end

		def authorize_update!
			if !current_user.admin? && cannot?(:"edit tickets", @Project)
				flash[:alert] = "You cannot edit tickets on this project."
				redirect_to @Project
			end
		end

		def authorize_delete!
			if !current_user.admin? && cannot?(:"delete tickets", @Project)
				flash[:alert] = "You cannot delete tickets from this project."
				redirect_to @Project
			end
		end

end
