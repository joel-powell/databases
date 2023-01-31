require_relative "book"

class BookRepository
  def all
    query = <<~SQL
      SELECT * FROM books
    SQL
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { Book.new(_1) }
  end
end
