require_relative "../lib/post_repository"

describe PostRepository do
  describe "#find_by_tag" do
    it "returns array of all posts for the given tag" do
      post_repository = PostRepository.new

      expected = [
        have_attributes(id: 4, title: "My weekend in Edinburgh"),
        have_attributes(id: 6, title: "A foodie week in Spain")
      ]

      expect(post_repository.find_by_tag("travel")).to match_array(expected)
    end
  end
end
