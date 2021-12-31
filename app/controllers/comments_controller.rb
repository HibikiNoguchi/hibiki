class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        image = Instagram.find(params[:instagram_id])
        comment = image.comments.build(comment_params)
        comment.user_id = current_user.id
        if comment.save
            flash[:success] = "コメントしました"
            redirect_back(fallback_location: root_path)
        else
            flash[:success] = "コメントできませんでした"
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        com = Comment.find(params[:id])
        com.destroy
        redirect_back(fallback_location: root_path)
    end

    private

        def comment_params
            params.require(:comment).permit(:content)
        end
end
