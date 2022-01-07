class InstagramsController < ApplicationController

    before_action :authenticate_user!
    def index
        if params[:search] != nil && params[:search] != ''
            search = params[:search]
            @images = Instagram.joins(:user).where("comment LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%")
        else
            @images = Instagram.all
        end
        @comment = Comment.new
    end

    def new
        @image = Instagram.new
    end
    
    
    def create
        image = Instagram.new(instagram_params)
        image.user_id = current_user.id
        if image.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def edit
        @image = Instagram.find(params[:id])
    end

    def update
        image = Instagram.find(params[:id])
        if image.update(instagram_params)
        redirect_to :action => "index"
        else
        redirect_to :action => "new"
        end
    end

    def show
        @image = Instagram.find(params[:id])
        @comments = @image.comments
        @comment = Comment.new
    end

    def destroy
        image = Instagram.find(params[:id])
        image.destroy
        redirect_to action: :index
    end

    private

    def instagram_params
        params.require(:instagram).permit(:comment, :image1 ) 
    end
end
