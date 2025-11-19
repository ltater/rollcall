class RsvpsController < ApplicationController
	def update
		@rsvp = Rsvp.find(params[:id])

		if @rsvp.update(status: params[:status])
			redirect_to @rsvp.game, notice: "RSVP updated for #{@rsvp.player.name}"
		else
			redirect_to @rsvp.game, alert: "Could not update RSVP"
		end
	end
end
