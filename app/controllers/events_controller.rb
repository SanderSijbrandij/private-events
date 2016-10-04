class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      EventUser.create(event_id: @event.id, user_id: current_user.id)
      flash[:success] = "Event created!"
      redirect_to @event
    else
      render 'new'
    end
  end

  def index
    #@events = Event.all.order(:happens_at)
    @past_events = Event.all.past_events
    @future_events = Event.all.future_events
  end

  def show
    @event = Event.find(params[:id])
  end

  # right now, you can sign up multiple times through URL...
  def attend
    event = Event.find(params[:id])
    if EventUser.create(event_id: event.id, user_id: current_user.id)
      flash[:success] = "You are registered to attend the event!"
    else
      flash[:warning] = "Can't attend, somehow."
    end
    redirect_to event
  end

  def cancel
    event = Event.find(params[:id])
    # This destroys the event itself.
    #if current_user.attended_events.where("event_id = ?",event.id).delete_all
    if EventUser.where("event_id = ? and user_id = ?",
                       params[:id], current_user.id).delete_all
      flash[:success] = "Removed you from this event."
      redirect_to event_path Event.find(params[:id])
    else
      flash[:warning] = "Something went wrong."
      redirect_to event_path Event.find(params[:id])
    end
  end

  private
    def event_params
      params.require(:event).permit(:name, :description, :location,
                                    :happens_at)
    end
end
