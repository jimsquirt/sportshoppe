class PagesController < ApplicationController
	def about

	end
  def public_products
    @products = Product.find_by_sql("SELECT * FROM products, users WHERE products.user_id = user.id ORDER products.created_at asc")
  end

  def newsfeed
  	@products = Product.order("created_at DESC").limit(10)
  	@comments = Comment.order("created_at DESC").limit(10)
    @popular = Like.find_by_sql("SELECT product_id, count(product_id) as num, name FROM likes LEFT JOIN products ON products.id = likes.product_id GROUP BY product_id ORDER BY num DESC LIMIT 10")
  end
end
