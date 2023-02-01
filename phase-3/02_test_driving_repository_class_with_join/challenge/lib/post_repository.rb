require_relative "post"
require_relative "comment"

class PostRepository
  def find_with_comments(id)
    query = <<~SQL
      SELECT
        posts.id,
        posts.title,
        posts.content AS "post_content",
        comments.id AS "comment_id",
        comments.author,
        comments.content AS "comment_content"
      FROM posts
          JOIN comments
              ON posts.id = comments.post_id
      WHERE posts.id = $1;
    SQL
    params = [id]
    result_set = DatabaseConnection.exec_params(query, params)
    post = record_to_post_object(result_set.first)
    result_set.each { post.comments << record_to_comment_object(_1) }
    post
  end

  private

  def record_to_post_object(record)
    post = Post.new
    post.id = record["id"].to_i
    post.title = record["title"]
    post.content = record["post_content"]
    post
  end

  def record_to_comment_object(record)
    comment = Comment.new
    comment.id = record["comment_id"].to_i
    comment.author = record["author"]
    comment.content = record["comment_content"]
    comment
  end
end
