# Posts Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: posts
id: SERIAL
title: text
content: text
views: int
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO posts (title, content, views, account_id)
VALUES ('first_post', 'this post has some content', 56, 1),
       ('second_post', 'some cool content', 34, 2),
       ('third_post', 'best content yet', 156, 1);
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then
suffixed by `Repository` for the Repository class name.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class,
including primary and foreign keys.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)

Post = Struct.new(:id, :title, :content, :views, :account_id)
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the
database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries
that will be used by each method.

```ruby
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # Creates a single record
  # One argument: a new post object
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4)

    # Returns nil.
  end

  # Updates a single record
  # One argument: a new post object
  def update(post)
    # Executes the SQL query:
    # UPDATE posts SET title = $2, content = $3, views = $4, account_id = $5 WHERE id = $1

    # Returns nil.
  end

  # Deletes a single record by its ID
  # One argument: the id (number)
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1;

    # Returns nil.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table
written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  3

posts[1].id # =>  2
posts[1].title # =>  'second_post'
posts[1].content # =>  'some cool content'
posts[1].views # =>  34
posts[1].account_id # =>  2

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'first_post'
post.content # =>  'this post has some content'
post.views # =>  56
post.account_id # =>  1

# 3
# Create a single record

repo = PostRepository.new

new_post = Post.new(title: 'new_title', content: 'some new content', views: 0, account_id: 2)

repo.create(new_post)

posts = repo.all

posts.includes(new_post)

# 4
# Updates an post

repo = PostRepository.new

updated_post = Post.new(id: 1, title: 'updated_title', content: 'some updated content', views: 66, account_id: 1)

repo.update(updated_post)

post = repo.find(1)

post.id # =>  1
post.title # =>  'updated_title'
post.content # =>  'some updated content'
post.views # =>  66
post.account_id # =>  1

# 5
# Deletes an post

repo = PostRepository.new

repo.delete(1)

repo.find(1) # => nil
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: 'localhost', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
