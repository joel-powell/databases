require_relative "post"

class PostRepository
  def find_by_tag(name)
    query = <<~SQL
      SELECT posts.id, posts.title
      FROM posts
      JOIN posts_tags on posts.id = posts_tags.post_id
      JOIN tags on tags.id = posts_tags.tag_id
      WHERE tags.name = $1;
    SQL
    params = [name]
    result_set = DatabaseConnection.exec_params(query, params)
    result_set.map { Post.new(hash_values_to_integers(_1)) }
  end

  private

  def hash_values_to_integers(hash)
    hash.transform_values { |value| Integer(value, exception: false) || value }
  end
end
