module Authors
  class HomesController < AuthorController

    def index
      @your_pages = current_author.pages.published
      @posts = Post.published
      @your_posts = current_author.posts.published
      @categories = Category.all
    end

  end
end
