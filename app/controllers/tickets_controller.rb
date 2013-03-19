class TicketsController < ApplicationController
	
	before_filter :authenticate_user!, :except => [:index, :show] 

	before_filter :find_project

	before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]



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
			@Project = Project.find(params[:project_id])
		end

		def find_ticket
			@ticket = @Project.tickets.find(params[:id])
		end



end
