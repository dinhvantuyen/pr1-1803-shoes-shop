class Admin::ProductsController < Admin::BaseController
  def index
    @products = Product.all
    @products = @products.paginate(page: params[:page]).per_page(30)
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
    @products = Product.paginate(page: params[:page])
  end

  def edit
    @product = Product.find_by id: params[:id]
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Profile updated success"
      redirect_to admin_products_path
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id]).destroy
    flash[:success] = "Đã xóa hãng thành công"
    redirect_to admin_products_path
  end


  private
    def product_params
      params.require(:product).permit :category_id, :name, :description, :price, :status, :image, :create_at
    end
end
