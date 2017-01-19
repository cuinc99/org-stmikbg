module Users
  class HomeController < UserController

    def index
      @events = Event.most_recent.published.paginate(:page => params[:page], :per_page => 9)
      @most_popular = Post.all.published.order(view: :desc).limit(5)
      @most_popular_event = Event.all.published.order(view: :desc).limit(5)
      @authors = Author.all
      @authors_ukm = Author.ukm
      @authors_sc = Author.sc
    end

  end
end
