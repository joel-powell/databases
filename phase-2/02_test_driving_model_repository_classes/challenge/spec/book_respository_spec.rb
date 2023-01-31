require_relative "../lib/book_repository"

def reset_books_table
  seed_sql = File.read("spec/seeds_books.sql")
  connection = PG.connect({ host: "localhost", dbname: "book_store_test" })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do
    reset_books_table
  end

  it "returns all books" do
    book_repository = BookRepository.new
    books = book_repository.all
    expect(books.length).to eq(2)
    expect(books.first.id).to eq("1")
    expect(books.first.title).to eq("Nineteen Eighty-Four")
    expect(books.first.author_name).to eq("George Orwell")
  end
end
