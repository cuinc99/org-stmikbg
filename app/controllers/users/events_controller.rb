module Users
  class EventsController < UserController

    def index
      @events = Event.most_recent.search(params[:search]).paginate(:page => params[:page], :per_page => 9)
      @most_popular = Post.all.published.order(view: :desc).limit(5)
      @most_popular_event = Event.all.published.order(view: :desc).limit(5)
      @authors = Author.all
    end

    def show
      @posts = Post.most_recent.published.paginate(:page => params[:page], :per_page => 9)
      @most_popular = Post.all.published.order(view: :desc).limit(3)
      @most_popular_event = Event.all.published.order(view: :desc).limit(5)
      @authors = Author.all

      @events = Event.most_recent.published.limit(5)
      @event = Event.friendly.find(params[:id])
      impressionist(@event)
    end
  end
end
