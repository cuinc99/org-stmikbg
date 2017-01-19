module Authors
  class CategoriesController < AuthorController
    before_action :find_category, only: [:show, :edit, :update, :destroy]

    def index
      @categories = Category.all.order("id desc")
      @category = Category.new
    end

    def create
      @category = Category.new category_params

      if @category.save
        redirect_to authors_categories_path, notice: "Alhamdulillah! your category is saved!"
      else
        render :index
      end
    end

    def edit
      @categories = Category.all.order("id desc")
    end

    def update
      if @category.update category_params
        redirect_to authors_categories_path, notice: "Alhamdulillah! your category is Updated!"
      else
        render :index
      end
    end

    def destroy
      @category.destroy
      redirect_to authors_categories_url
    end

    private
    def category_params
      params.require(:category).permit(:title, :slug)
    end

    def find_category
      @category = Category.friendly.find(params[:id])
    end
  end
end
