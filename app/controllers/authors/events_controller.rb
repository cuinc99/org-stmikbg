module Authors
  class EventsController < AuthorController
    before_action :find_event, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

    def index
      @events = current_author.events.most_recent.paginate(:page => params[:page], :per_page => 10).where("title like ?","%#{params[:search]}%")
    end

    def new
      @event = current_author.events.new
    end

    def create
      @event = current_author.events.new(event_params)

      if @event.save
        redirect_to authors_events_path, notice: "Alhamdulillah! your event is saved!"
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @event.update(event_params)
        redirect_to authors_events_path, notice: "Alhamdulillah! your event is updated!"
      else
        render :edit
      end
    end

    def destroy
      @event.destroy
      redirect_to authors_events_url
    end

    def publish
      @event.publish
      redirect_to authors_events_url, notice: "Yeah! your event is published"
    end

    def unpublish
      @event.unpublish
      redirect_to authors_events_url, notice: "Oh no! your event is unpublished"
    end

    private
    def event_params
      params.require(:event).permit(:title, :description, :status, :quota, :start, :end, :location, :link_register, :published_at, :published, :slug, :image)
    end

    def find_event
      @event = current_author.events.friendly.find(params[:id])
    end

  end
end
