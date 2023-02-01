require_relative "lib/database_connection"
require_relative "lib/post_repository"

class Application
  def initialize(database_name, io, post_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @post_repository = post_repository
  end

  def run
    post = @post_repository.find_with_comments(1)

    puts post.title
    puts post.content
    puts "Comments:"
    puts post.comments.map { "#{_1.author} - #{_1.content}" }.join("\n")
  end
end

if __FILE__ == $PROGRAM_NAME
  app = Application.new(
    "blog",
    Kernel,
    PostRepository.new
  )
  app.run
end
