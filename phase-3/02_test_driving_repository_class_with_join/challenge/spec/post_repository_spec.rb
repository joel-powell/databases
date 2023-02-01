require_relative "../lib/post_repository"

def reset_tables
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "localhost", dbname: "blog" })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_tables
  end

  describe "#find_with_comments" do
    context "given a post id of 1" do
      it "returns the post object also containing an array of corresponding comment objects" do
        post_repository = PostRepository.new
        post = post_repository.find_with_comments(1)

        expected = have_attributes(
          id: 1,
          title: "post_1",
          content: "content_1",
          comments: [
            have_attributes(id: 1, author: "Alice", content: "comment_1"),
            have_attributes(id: 4, author: "Dan", content: "comment_4")
          ]
        )

        expect(post).to match(expected)
      end
    end

    context "given a post id of 2" do
      it "returns the post object also containing an array of corresponding comment objects" do
        post_repository = PostRepository.new
        post = post_repository.find_with_comments(2)

        expected = have_attributes(
          id: 2,
          title: "post_2",
          content: "content_2",
          comments: [
            have_attributes(id: 2, author: "Bob", content: "comment_2"),
            have_attributes(id: 3, author: "Carry", content: "comment_3")
          ]
        )

        expect(post).to match(expected)
      end
    end
  end
end
