class RecipesController < ApplicationController
  def index
    @all_recipes = Category.find(params[:category_id]).recipes
    if @all_recipes.empty?
      render json: {
          'error': 'No data to show'
      }
    else
      render :json => {
          :response => "Success",
          :data => @all_recipes
      }
    end
  end
  def create
    @onerecipe = Recipe.new(recipe_params)
    if @onerecipe.save
      render :json => {
          :response => 'Created',
          :data => @onerecipe
      }
    else
      render :json => {
          :error => 'Cant be saved'
      }
    end
  end
  def show
  # this only shows  recipe without taking in consideration the category part of the url
  #   @single_recipe = Recipe.exists?(params[:id])
  #   if @single_recipe
  #     render :json => {
  #         :response => 'Success',
  #         :data => Recipe.find(params[:id])
  #     }
  #   else
  #     render :json => {
  #         :response => 'Not found',
  #     }
  #   end

    @therecipe=Category.exists?(params[:category_id])
    @single_recipe=Recipe.where(category_id: params[:category_id]).exists?(params[:id])
    if (@therecipe && @single_recipe == true )
        render :json => {
            :response => "Success",
        #whithout following line info wont be displayed.
            :data => Recipe.find(params[:id])
        }
      else
        render :json => {
            :error => "Not found"
        }
      end
  end

  def update
    if (@single_recipe_update = Recipe.find_by_id(params[:id])).present?
      @single_recipe_update.update(recipe_params)
      render :json => {
          :response => 'Updated',
          :data => @single_recipe_update
      }
    else
      render :json => {
          :response => 'Cannot update'
      }
    end
    #was not able to figure out how to update  taking category id in consideration getting a 500 error here
  #   if(@single_recipe_update = Recipe.find_by_id(params[:id]).present? &&
  #       Recipe.where(category_id: params[:category_id]).exists?(params[:id]))
  #     @single_recipe_update.update(recipe_params)
  #     render :json => {
  #         :response => "Success",
  #         :data => @single_recipe_update
  #     }
  #   else
  #     render :json => {
  #         :error => "Not found"
  #     }
  #   end
  end

  def destroy
    if (@recipe_delete = Recipe.find_by_id(params[:id])).present?
      @recipe_delete.destroy
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
  def recipe_params
    params.permit(:name, :ingredients, :directions, :notes, :tags, :category_id)
  end
end
