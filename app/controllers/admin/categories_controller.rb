class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    raise @categories.inspect
  end

  def new
  end

  def create
  end
end
