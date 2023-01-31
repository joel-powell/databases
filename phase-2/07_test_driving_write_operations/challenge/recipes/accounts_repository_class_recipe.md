# Accounts Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: accounts
id: SERIAL
email: text
username: text
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE accounts RESTART IDENTITY;

INSERT INTO accounts (email, username)
VALUES ('test@email.com', 'user_one'),
       ('email@testing.co.uk', 'user_two');
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then
suffixed by `Repository` for the Repository class name.

```ruby
# Table name: accounts

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class,
including primary and foreign keys.

```ruby
# Table name: accounts

# Model class
# (in lib/account.rb)

Account = Struct.new(:id, :email, :username)
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the
database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries
that will be used by each method.

```ruby
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM accounts;

    # Returns an array of Account objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM accounts WHERE id = $1;

    # Returns a single Account object.
  end

  # Creates a single record
  # One argument: a new account object
  def create(account)
    # Executes the SQL query:
    # INSERT INTO accounts (email, username) VALUES ($1, $2)

    # Returns nil.
  end

  # Updates a single record
  # One argument: a new account object
  def update(account)
    # Executes the SQL query:
    # UPDATE accounts SET email = $2, username = $3 WHERE id = $1

    # Returns nil.
  end

  # Deletes a single record by its ID
  # One argument: the id (number)
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM accounts WHERE id = $1;

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
# Get all accounts

repo = AccountRepository.new

accounts = repo.all

accounts.length # =>  2

accounts[0].id # =>  1
accounts[0].email # =>  'test@email.com'
accounts[0].username # =>  'user_one'

accounts[1].id # =>  2
accounts[1].email # =>  'email@testing.co.uk'
accounts[1].username # =>  'user_two'

# 2
# Get a single account

repo = AccountRepository.new

account = repo.find(1)

account.id # =>  1
account.email # =>  'test@email.com'
account.username # =>  'user_one'

# 3
# Create a single record

repo = AccountRepository.new

new_account = Account.new(email: 'test_new@email.co.uk', username: 'new_user')

repo.create(new_account)

accounts = repo.all

accounts.includes(new_account)

# 4
# Updates an account

repo = AccountRepository.new

updated_account = Account.new(id: 2, email: 'updated_email@testing.co.uk', username: 'updated_user')

repo.update(updated_account)

account = repo.find(2)

account.id # =>  2
account.email # =>  'updated_email@testing.co.uk'
account.username # =>  'updated_user'

# 5
# Deletes an account

repo = AccountRepository.new

repo.delete(1)

repo.find(1) # => nil
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/account_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: 'localhost', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe AccountRepository do
  before(:each) do
    reset_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
