class LikesController < ApplicationController
  def index
  end

  def create
  @product = Product.find(params[:product_id])
    @like = @product.likes.build(params[:like])
    respond_to do |format|
      if @like.save
        format.html { redirect_to(@product, :notice => 'Like was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { redirect_to(@product, :notice => 
        'like could not be saved.')}
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    
    if @like.destroy
      message = 'Like was successfully deleted.'
    else
      message = 'like could not be deleted.'
    end

    redirect_to(product_path(params[:product_id]), :notice => message)
  end
end
