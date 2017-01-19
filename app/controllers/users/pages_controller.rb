module Users
  class PagesController < UserController
    def index
      @pages = Page.published
    end

    def show
      @authors = Author.all
      @page = Page.friendly.find(params[:id])
    end
  end
end
