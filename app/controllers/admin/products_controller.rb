class Admin::ProductsController < Admin::BaseController
  def index
    @products = Product.all
    @products = @products.search_name params[:search_name] if params[:search_name].present?
    @products = @products.search_category params[:category_id] if params[:category_id].present?
    @categories_for_search = Category.pluck(:name, :id)
    @products = @products.paginate page: params[:page], per_page: 5
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "product created success"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find_by id: params[:id]
  end

  def edit
    @product = Product.find_by id: params[:id]
  end

  def update
    @product = Product.find_by id: params[:id]
    if @product.update_attributes product_params
      flash[:success] = "Profile updated success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id]).destroy
    flash[:success] = "Đã xóa hãng thành công"
    redirect_to admin_products_path
  end

  private
    def product_params
      params.require(:product).permit :category_id, :name, :description, :price, :status, :image
    end
end
