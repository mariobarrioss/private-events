class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @past_events = Event.all.past
    @upcoming_events = Event.all.upcoming
  end

  def show
  end

  def new
    @event = current_user.events.build
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)
    event_attendance = EventAttendance.new(attended_event: @event, attendee: current_user)

    respond_to do |format|
      if @event.save
        event_attendance.save
        format.html { redirect_to current_user, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to current_user, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def attend_event
    @event = Event.find_by(id: params[:event_id])
    event_attendance = EventAttendance.new(attended_event: @event, attendee: current_user)
    if  event_attendance.save 
      flash[:notice] = 'Your attendance has been registered'
      redirect_to current_user
    end
  end

  def cancel_attendance
    @event = Event.find_by(id: params[:event_id])
    EventAttendance.find_by(attended_event: @event, attendee: current_user).destroy
    flash[:notice] = 'Your attendance has been canceled'
    redirect_to current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :ds, :date)
    end
end
