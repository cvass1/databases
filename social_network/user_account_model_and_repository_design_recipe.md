# Social Network Model and Repository Classes Design Recipe


## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

```
| Record                | Properties          |
| --------------------- | ------------------  |
| user_account          | email_address, username
| post                  | title, content, number_of_views



```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_user_accounts.sql)

TRUNCATE TABLE posts, user_accounts RESTART IDENTITY; 

INSERT INTO user_accounts (email_address, username) VALUES ('my_email_1@gmail.com', 'my_username_1');
INSERT INTO user_accounts (email_address, username) VALUES ('my_email_2@gmail.com', 'my_username_2');

INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('post_1', 'this is my first post', 10, 1);
INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('post_2', 'this is my second post', 20, 1);

-- (file: spec/seeds_posts.sql)

TRUNCATE TABLE posts RESTART IDENTITY; 

INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('post_1', 'this is my first post', 10, 1);
INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('post_2', 'this is my second post', 20, 1);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network < seeds_user_accounts.sql

psql -h 127.0.0.1 social_network < seeds_posts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)
class UserAccount
end

# Repository class
# (in lib/user_account_repository.rb)
class UserAccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)

class UserAccount
  attr_accessor :id, :email_address, :username
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: user_accounts

# Repository class
# (in lib/user_account_repository.rb)

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts;

    # Returns an array of UserAccount objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # 'SELECT id, email_address, username FROM user_accounts WHERE id = $1;;

    # Returns a single UserAccount object.
  end

  def create(user_account)
  # adds a new record into the database
  # 'INSERT INTO user_accounts (email_address, username) VALUES ($1, $2);'	
  end

  def update(user_account)
  # updates a record in the database
  # 'UPDATE user_accounts SET email_address = $1, username = $2 WHERE id = $3;'

  end

  def delete(user_account)
  # deletes a record in the database
  # 'DELETE FROM user_accounts WHERE id = $1;'
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all user_accounts

repo = UserAccountRepository.new

user_accounts = repo.all

user_accounts.length # =>  2

user_accounts[0].id # =>  1
user_accounts[0].email_address # =>  'my_email_1@gmail.com'
user_accounts[0].username # =>  'my_username_1'

user_accounts[1].id # =>  2
user_accounts[1].email_address # =>  'my_email_2@gmail.com'
user_accounts[1].username # =>  'my_username_2'

# 2
# Get a single user_account

repo = UserAccountRepository.new

user_account = repo.find(1)

user_account.id # =>  1
user_account.email_address # =>  'my_email_1@gmail.com'
user_account.username # =>  'my_username_1'

# 3
# create a new user_account

repo = UserAccountRepository.new

user_account = UserAccount.new

user_account.email_address = 'my_email_3@gmail.com'
user_account.username = 'my_username_3'

repo.create(user_account)

last_user_account = repo.all.last

last_user_account.id # => 3
last_user_account.email_address # =>'my_email_3@gmail.com'
last_user_account.username # =>'my_username_3'


# 4
# delete a user_account from the database

repo = UserAccountRepository.new

repo.delete(2)

repo.all.length # => 1
last_user_account = repo.all.last
last_user_account.id #=> 1
last_user_account.email_address # =>'my_email_1@gmail.com'
last_user_account.username # =>'my_username_1'

# 5 
# update a user_account in the database

repo = UserAccountRepository.new

user_account = repo.find(1)

user_account.email_address = 'my_NEW_email_1@gmail.com'

user_account.username = 'my_NEW_username_1'

repo.update(user_account)

updated_user_account = repo.find(1)

updated_user_account.id # =>  1
updated_user_account.email_address # =>  'my_NEW_email_1@gmail.com'
updated_user_account.username # =>  'my_NEW_username_1'





```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/user_account_repository_spec.rb

def reset_user_account_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserAccountRepository do
  before(:each) do 
    reset_user_account_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._