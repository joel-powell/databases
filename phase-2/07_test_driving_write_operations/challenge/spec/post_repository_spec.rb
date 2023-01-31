require_relative "../lib/post_repository"
require_relative "reset_tables"

describe PostRepository do
  before(:each) do
    reset_tables
  end

  describe "#all" do
    it "returns all posts" do
      repo = PostRepository.new

      posts = repo.all

      expect(posts.length).to eq(3)

      expected = [
        have_attributes(
          id: 1,
          title: "first_post",
          content: "this post has some content",
          views: 56,
          account_id: 1
        ),
        have_attributes(
          id: 2,
          title: "second_post",
          content: "some cool content",
          views: 34,
          account_id: 2
        ),
        have_attributes(
          id: 3,
          title: "third_post",
          content: "best content yet",
          views: 156,
          account_id: 1
        )
      ]

      expect(posts).to match_array(expected)
    end
  end

  describe "#find" do
    context "given an id of 1" do
      it "returns the post with id 1" do
        repo = PostRepository.new

        post = repo.find(1)

        expected = have_attributes(
          id: 1,
          title: "first_post",
          content: "this post has some content",
          views: 56,
          account_id: 1
        )

        expect(post).to match(expected)
      end
    end
  end

  describe "#create" do
    context "given a new post object" do
      it "adds the post to the database" do
        repo = PostRepository.new

        new_post = Post.new(title: "new_title", content: "some new content", views: 0, account_id: 2)

        repo.create(new_post)

        expect(repo.all).to include(have_attributes(new_post.to_h.except(:id)))
      end
    end
  end

  describe "#update" do
    context "given an updated post object" do
      it "updates the record with the given id to the new values" do
        repo = PostRepository.new

        updated_post = Post.new(id: 1, title: "updated_title", content: "some updated content", views: 66,
                                account_id: 1)

        repo.update(updated_post)

        post = repo.find(1)

        expected = have_attributes(
          id: 1,
          title: "updated_title",
          content: "some updated content",
          views: 66,
          account_id: 1
        )

        expect(post).to match(expected)
      end
    end
  end

  describe "#delete" do
    context "given an id of 1" do
      it "deletes the post with id 1" do
        repo = PostRepository.new

        repo.delete(1)

        expect(repo.find(1)).to eq nil
      end
    end
  end
end
