class ProductsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    #@products = current_user.products.search(params[:search]).order(sort_column + ' ' + sort_direction)
     @products = current_user.products.search(params[:search])

  end

  def public_products
    
    @products = Product.search(params[:search])
      
  end

  def login
    
  end

  def show
    @product = Product.find(params[:id])
    @comment = Comment.new 
    
    @num_likes = Like.where(:product_id => @product.id).count
    if current_user
      @like = Like.where(:product_id => @product.id, :user_id => current_user.id).first
      @like = Like.new if @like.nil?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end


  def edit
    @product = Product.find(params[:id])
  end


  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        current_user.products << @product
        format.html { redirect_to products_path, :notice => 'product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    if current_user.admin
      redirect_to admin_products_url, notice: 'product successfully deleted' 
    else
      redirect_to products_url, notice: 'product successfully deleted' 
    end
  end

   private
  def sort_column
    product.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
