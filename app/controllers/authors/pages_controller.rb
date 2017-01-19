module Authors
  class PagesController < AuthorController
    before_action :find_page, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

    def index
      @pages = current_author.pages.most_recent.all.paginate(:page => params[:page], :per_page => 10)
    end

    def new
      @page = current_author.pages.new
    end

    def create
      @page = current_author.pages.new page_params

      if @page.save
        redirect_to authors_pages_path, notice: "Alhamdulillah! your page is saved!"
      else
        render :index
      end
    end

    def edit
      @pages = current_author.pages.all.order("id desc")
    end

    def update
      if @page.update page_params
        redirect_to authors_pages_path, notice: "Alhamdulillah! your page is Updated!"
      else
        render :index
      end
    end

    def destroy
      @page.destroy
      redirect_to authors_pages_url
    end

    def publish
      @page.publish
      redirect_to authors_pages_url, notice: "Pages has been published"
    end

    def unpublish
      @page.unpublish
      redirect_to authors_pages_url
    end

    private
    def page_params
      params.require(:page).permit(:title, :content, :slug, :image)
    end

    def find_page
      @page = current_author.pages.friendly.find(params[:id])
    end
  end
end
