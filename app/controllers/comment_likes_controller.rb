class CommentLikesController < ApplicationController
    def create
        comment_like = current_user.comment_likes.create(comment_id: params[:comment_id]) 
        redirect_back(fallback_location: root_path)
      end
    
      def destroy
        comment_like = CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
        comment_like.destroy
        redirect_back(fallback_location: root_path)
      end
    
end
