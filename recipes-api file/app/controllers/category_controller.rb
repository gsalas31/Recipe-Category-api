class CategoryController < ApplicationController
  def index
    @all_categories = Category.all
    if @all_categories.empty?
      render json: {
          'error': 'No data to show'
      }
    else
      render :json => {
          :response => "Success",
          :data => @all_categories
      }
    end
  end
  def create
    @one = Category.new(category_params)
    if @one.save
      render :json => {
          :response => 'Created',
          :data => @one
      }
    else
      render :json => {
          :error => 'Cant be saved'
      }
    end
  end
  def show
    @single_category = Category.exists?(params[:id])
    if @single_category
      render :json => {
          :response => 'Success',
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :response => 'Not found',
      }
    end
  end
  def update
    if (@single_category_update = Category.find_by_id(params[:id])).present?
      @single_category_update.update(category_params)
      render :json => {
          :response => 'Updated',
          :data => @single_category_update
      }
    else
      render :json => {
          :response => 'Cannot update'
      }
    end
  end
  def destroy
    if (@category_delete = Category.find_by_id(params[:id])).present?
      @category_delete.destroy
      render :json => {
          :response => 'Successfully deleted'
      }
    else
      render :json => {
          :response => 'Cannot delete'
      }
    end
  end

  private
  def category_params
    params.permit(:title, :description, :created_by)
  end

end
