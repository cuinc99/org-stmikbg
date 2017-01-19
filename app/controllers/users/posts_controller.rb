module Users
  class PostsController < UserController

    def index
      @posts = Post.most_recent.search(params[:search]).paginate(:page => params[:page], :per_page => 9)
      @most_popular = Post.all.published.order(view: :desc).limit(5)
      @authors = Author.all
      @authors_ukm = Author.ukm
      @authors_sc = Author.sc
    end

    def show
      @posts = Post.most_recent.published.paginate(:page => params[:page], :per_page => 9)
      @most_popular = Post.all.published.order(view: :desc).limit(3)
      @authors = Author.all

      @post = Post.friendly.find(params[:id])
      impressionist(@post)
      @current_user_post = @post.author.posts.most_recent.published.limit(3)
    end
  end
end
