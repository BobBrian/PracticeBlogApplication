#Instead of using a CRUD scaffold we physically created this 
#contoller
before_action :authenticate_user!, except: [:index, :show]
before_action :set_blog_post, except: [:index, :new, :create]

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

  def edit
    @blog_post = BlogPost.find(params[:id])
  end

  def update
    @blog_post = BlogPost.find(params[:id])
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord:RecordNotFound
    redirect_to root_path
  end

  def authenticate_user
    redirect_to new_user_session_path, alert: "You must Sign Up or Sign In to continue" unless user_signed_in?
  end


end