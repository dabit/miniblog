module Miniblog::Admin::PostsHelper
  def edit_post_button(post)
    link_to 'Edit', miniblog.edit_admin_post_path(post),
        class: "btn btn-default btn-block"
  end

  def delete_post_button(post)
    link_to 'Delete', miniblog.admin_post_path(post),
        class: "btn btn-default btn-block",
        method: :delete, data: { confirm: "Are you sure?"}
  end

  def publish_post_button(post)
    link_to 'Publish', '#', class: "btn btn-block #{post.published? ? "btn-success" : "btn-danger" }"
  end
end
