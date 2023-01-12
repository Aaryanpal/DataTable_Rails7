class ProductsController < ApplicationController
  def index
    @products = Product.all
    @products = @products.search(params[:query]) if params[:query].present?
    @pagy, @products = pagy @products.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)
  end

  def sort_column
    %w[name categories current_price actual_price discount rating].include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w{asc desc}.include?(params[:direction]) ? params[:direction] : "asc" 
  end
  
end
