module Users
  class AuthorController < UserController
    def show
      @authors = Author.all
      @author = Author.friendly.find(params[:id])
      @most_popular = Post.all.published.order(view: :desc).limit(3)
      @posts = @author.posts.published.limit(6)
      @pages = @author.pages.published
      @events = @author.events.published
    end
  end
end