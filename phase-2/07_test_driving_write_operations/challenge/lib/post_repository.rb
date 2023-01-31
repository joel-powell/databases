require_relative "post"
require_relative "format"

class PostRepository
  include Format

  def all
    query = <<~SQL
      SELECT * FROM posts;
    SQL
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { Post.new(hash_values_to_integers(_1)) }
  end

  def find(id)
    query = <<~SQL
      SELECT * FROM posts
      WHERE id = $1;
    SQL
    params = [id]
    result_set = DatabaseConnection.exec_params(query, params)
    record = result_set.first

    Post.new(hash_values_to_integers(record)) unless record.nil?
  end

  def create(post)
    query = <<~SQL
      INSERT INTO posts (title, content, views, account_id)
      VALUES ($1, $2, $3, $4);
    SQL
    params = [post.title, post.content, post.views, post.account_id]
    DatabaseConnection.exec_params(query, params)
  end

  def update(post)
    query = <<~SQL
      UPDATE posts
      SET title = $2, content = $3, views = $4, account_id = $5
      WHERE id = $1;
    SQL
    params = [post.id, post.title, post.content, post.views, post.account_id]
    DatabaseConnection.exec_params(query, params)
  end

  def delete(id)
    query = <<~SQL
      DELETE FROM posts
      WHERE id = $1;
    SQL
    params = [id]
    DatabaseConnection.exec_params(query, params)
  end
end
