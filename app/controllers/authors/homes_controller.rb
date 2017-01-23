module Authors
  class HomesController < AuthorController

    def index
      @your_pages = current_author.pages.published
      @posts = Post.published
      @your_posts = current_author.posts.published
      @your_events = current_author.events.published
      @categories = Category.all
    end

  end
end
