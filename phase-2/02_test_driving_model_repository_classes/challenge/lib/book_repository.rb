require_relative "book"

class BookRepository
  def all
    sql = "SELECT * FROM books"
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.map { Book.new(_1) }
  end
end
