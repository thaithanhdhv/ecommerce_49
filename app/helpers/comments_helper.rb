module CommentsHelper
  def can_edit_comment? comment
    comment.user_id == current_user.id
  end
end
