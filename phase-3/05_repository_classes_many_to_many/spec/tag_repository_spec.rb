require_relative "../lib/tag_repository"

describe TagRepository do
  describe "#find_by_post" do
    it "returns array of all posts for the given tag" do
      tag_repository = TagRepository.new

      expected = [
        have_attributes(id: 1, name: "coding"),
        have_attributes(id: 4, name: "ruby")
      ]

      expect(tag_repository.find_by_post(2)).to match_array(expected)
    end
  end
end
