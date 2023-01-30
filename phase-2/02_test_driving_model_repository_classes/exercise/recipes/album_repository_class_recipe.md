# Albums Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: albums

Columns:
id | title | release_year | artist_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE albums RESTART IDENTITY;

INSERT INTO albums (title, release_year, artist_id)
VALUES ('Doolittle', 1989, 1),
       ('Surfer Rosa', 1988, 1),
       ('Super Trouper', 1980, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any
existing records in the table will be deleted.

```bash
psql -h localhost music_library_test < spec/seeds_albums.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then
suffixed by `Repository` for the Repository class name.

```ruby
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class,
including primary and foreign keys.

```ruby
# Table name: albums

# Model class
# (in lib/album.rb)

Album = Struct.new(:id, :title, :release_year, :artist_id)
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably
not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the
database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries
that will be used by each method.

```ruby
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM albums;

    # Returns an array of Album objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM albums WHERE id = $1;

    # Returns a single Album object.
  end

  def create(album)
    # Executes the SQL query:

    # INSERT INTO albums (title, release_year, artist_id)
    # VALUES ($1,$2,$3);

    # Returns created object
  end

  def delete(album)
    # Executes the SQL query:

    # DELETE FROM albums
    # WHERE id = $1;

    # Returns ?
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table
written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all

albums.length # =>  3

albums.first.id # =>  '1'
albums.first.title # =>  'Doolittle'
albums.first.release_year # =>  '1989'

# 2
# Get a single album

repo = AlbumRepository.new

album = repo.find(2)

album.id # =>  2
album.title # =>  'Surfer Rosa'
album.release_year # =>  '1988'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/album_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: 'localhost', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do
    reset_albums_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._