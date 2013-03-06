class AdminController < ApplicationController
	def index
  		@products = Product.order("created_at DESC")
  		@comments = Comment.order("created_at DESC")
   		@popular = Like.find_by_sql("SELECT product_id, count(product_id) as num, name FROM likes LEFT JOIN products ON products.id = likes.product_id GROUP BY product_id ORDER BY num DESC")		
	end

	def products
		@products = Product.all
	end

	def users
		@users = User.all
	end

	def promote
		@user = User.find(params[:id])
		@user.update_attribute(:admin, true)
		redirect_to admin_users_path, :notice => "Promoted"
	end

	def comments
		@comments = Comment.all
	end

	def messages
		@messages = Message.all
	end
end
