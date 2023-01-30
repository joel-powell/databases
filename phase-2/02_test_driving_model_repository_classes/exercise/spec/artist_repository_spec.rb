require_relative "../lib/artist_repository"

def reset_artists_table
  seed_sql = File.read("spec/seeds_artist.sql")
  connection = PG.connect({ host: "localhost", dbname: "music_library_test" })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do
    reset_artists_table
  end

  it "returns a list of artists" do
    repo = ArtistRepository.new

    artists = repo.all

    expect(artists.length).to eq(2)
    expect(artists.first.id).to eq("1")
    expect(artists.first.name).to eq("Pixies")
    expect(artists.first.genre).to eq("Rock")
  end
end
