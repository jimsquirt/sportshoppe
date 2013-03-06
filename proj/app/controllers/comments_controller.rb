class CommentsController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @comment = @product.comments.all
  end


def create
  @product = Product.find(params[:product_id])
    @comment = @product.comments.build(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@product, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { redirect_to(@product, :notice => 
        'Comment could not be saved.')}
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      msg = "deleted na, pagcriminal case na"
    else
      msg = "di mada bai"
    end
    if current_user.admin
      redirect_to admin_comments_path, :notice => msg
    end
  end

end
