class PagesController < ApplicationController
  before_filter :find_page, only: [:show, :edit, :update, :destroy]
  
  def index
  	@pages = Page.all
  end
  
  def new
  	@page = Page.new(:parent_id => params[:parent_id])
  end
  
  def edit
  	respond_to do |format|
  		format.html
  	end
  end
  
  def create
  	@page = Page.new(page_params)
  	if @page.save
  		redirect_to nested_pages_path(@page)
  	else
  		render 'new'
  	end
  end
  
  def show
  end
  
  def update
  	if @page.update(page_params)
		  redirect_to nested_pages_path(@page)
		  update_children_slugs(@page)
		else
		  render 'edit'
		end
  end
  
  def destroy
  	@page.destroy
  	redirect_to root_path
  end
  
private
  
  # если у страницы есть подстраницы, то обновляем их slug-и
  def update_children_slugs(page)
    if page.has_children?
      page.children.each do |child|
        child.slug = [child.parent.slug, child.slug.split('/').last].join('/')
        child.save!
        update_children_slugs(child)
      end
    end
  end
  
  def find_page
  	@page = Page.find_by_slug!(params[:slug])
  end
  
  def page_params
  	params.require(:page).permit(:name, :title, :content, :parent_id)
  end
end
