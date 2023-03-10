# Artists Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: artists

Columns:
id | name | genre
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE artists RESTART IDENTITY;

INSERT INTO artists (name, genre)
VALUES ('Pixies', 'Rock'),
       ('ABBA', 'Pop');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any
existing records in the table will be deleted.

```bash
psql -h localhost music_library_test < spec/seeds_artists.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then
suffixed by `Repository` for the Repository class name.

```ruby
# Table name: artists

# Model class
# (in lib/artist.rb)
class Artist
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class,
including primary and foreign keys.

```ruby
# Table name: artists

# Model class
# (in lib/artist.rb)

class Artist

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :genre
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# artist = Artist.new
# artist.name = 'Jo'
# artist.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably
not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the
database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries
that will be used by each method.

```ruby
# Table name: artists

# Repository class
# (in lib/artist_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM artists;

    # Returns an array of Artist objects.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table
written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all artists

repo = ArtistRepository.new

artists = repo.all

artists.length # =>  2
artists.first.id # =>  1
artists.first.name # =>  'Pixies'
artists.first.genre # =>  'Pop'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/artist_repository_spec.rb

def reset_artists_table
  seed_sql = File.read("spec/seeds_artists.sql")
  connection = PG.connect({ host: "localhost", dbname: "music_library_test" })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do
    reset_artists_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._