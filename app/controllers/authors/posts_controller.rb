module Authors
  class PostsController < AuthorController
    before_action :find_post, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

    def index
      @posts = current_author.posts.most_recent.paginate(:page => params[:page], :per_page => 10).where("title like ?","%#{params[:search]}%")
    end

    def new
      @post = current_author.posts.new
    end

    def create
      @post = current_author.posts.new(post_params)

      if @post.save
        redirect_to authors_posts_path, notice: "Alhamdulillah! your post is saved!"
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to authors_posts_path, notice: "Alhamdulillah! your post is updated!"
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      redirect_to authors_posts_url
    end

    def publish
      @post.publish
      redirect_to authors_posts_url, notice: "Yeah! your post is published"
    end

    def unpublish
      @post.unpublish
      redirect_to authors_posts_url, notice: "Oh no! your post is unpublished"
    end

    private
    def post_params
      params.require(:post).permit(:title, :content, :image, :tag_list, :published_at, :published, :slug, category_ids: [])
    end

    def find_post
      @post = current_author.posts.friendly.find(params[:id])
    end

  end
end
