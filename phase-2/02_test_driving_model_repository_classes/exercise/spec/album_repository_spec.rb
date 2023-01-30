require_relative "../lib/album_repository"

def reset_albums_table
  seed_sql = File.read("spec/seeds_albums.sql")
  connection = PG.connect({ host: "localhost", dbname: "music_library_test" })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do
    reset_albums_table
  end

  it "returns all albums" do
    repo = AlbumRepository.new

    albums = repo.all

    expect(albums.length).to eq(3)
    expect(albums.first.id).to eq("1")
    expect(albums.first.title).to eq("Doolittle")
    expect(albums.first.release_year).to eq("1989")
  end

  it "returns an album by id" do
    repo = AlbumRepository.new

    album = repo.find(2)

    expect(album.id).to eq("2")
    expect(album.title).to eq("Surfer Rosa")
    expect(album.release_year).to eq("1988")
  end
end
