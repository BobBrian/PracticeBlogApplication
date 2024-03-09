#Instead of using a CRUD scaffold we physically created this 
#contoller

class BlogPostsController < ApplicationController
  def index 
    @blog_posts = BlogPost.all
  end

  #Gives us a Params method that return us all the parameters for the request
  def show
    @blog_post = BlogPost.find(params[:id])
    #A way to route users back to the homepage if they enter a invalid ID
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end

  def new
    @blog_post = BlogPost.new
  end

  #Method to save data into database
  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

end