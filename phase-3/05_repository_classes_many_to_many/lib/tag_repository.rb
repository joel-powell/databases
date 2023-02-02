require_relative "tag"

class TagRepository
  def find_by_post(id)
    query = <<~SQL
      SELECT tags.id, tags.name
      FROM tags
      JOIN posts_tags on tags.id = posts_tags.tag_id
      JOIN posts on posts.id = posts_tags.post_id
      WHERE posts.id = $1;
    SQL
    params = [id]
    result_set = DatabaseConnection.exec_params(query, params)
    result_set.map { Tag.new(hash_values_to_integers(_1)) }
  end

  private

  def hash_values_to_integers(hash)
    hash.transform_values { |value| Integer(value, exception: false) || value }
  end
end
