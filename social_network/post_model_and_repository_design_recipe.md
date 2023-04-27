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

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)

class Post
  attr_accessor :id, :title, :content, :number_of_views, :user_account_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_account_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # 'SELECT id, title, content, number_of_views, user_account_id WHERE id = $1;'

    # Returns a single Post object.
  end

  def create(post)
  # adds a new record into the database
  # 'INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ($1, $2, $3, $4);'	
  end

  def update(post)
  # updates a record in the database
  # 'UPDATE posts SET title = $1, content = $2, number_of_views = $3, user_account_id =$4 WHERE id = $5;'

  end

  def delete(post)
  # deletes a record in the database
  # 'DELETE FROM posts WHERE id = $1;'
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  'post_1'
posts[0].content # =>  'this is my first post'
posts[0].number_of_views # => 10
posts[0].user_account_id # => 1


posts[1].id # =>  2
posts[1].title # =>  'post_2'
posts[1].content # =>  'this is my second post'
posts[1].number_of_views # => 20
posts[1].user_account_id # => 1


# 2
# Get a single user_account

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'post_1'
post.content # =>  'this is my first post'
post.number_of_views # => 10
post.user_account_id # => 1

# 3
# create a new user_account

repo = PostRepository.new

post = Post.new

post.title = 'post_3'
post.content = 'this is my third post'
post.number_of_views = 30
post.user_account_id = 2


repo.create(post)

last_post = repo.all.last

last_post.id # => 3
last_post.title # => 'post_3'
last_post.content # =>'this is my third post'
last_post.number_of_views # => 30
last_post.user_account_id # => 2



# 4
# delete a user_account from the database

repo = PostRepository.new

repo.delete(2)

repo.all.length # => 1
last_post = repo.all.last
last_post.id #=> 1
last_post.title # => 'post_1'
last_post.content # =>'this is my first post'
last_post.number_of_views # => 10
last_post.user_account_id # => 1


# 5 
# update a user_account in the database

repo = PostRepository.new

post = repo.find(1)

post.title = 'NEW_post_1'
post.content = 'this is my NEW first post'


repo.update(post)

updated_post = repo.find(1)

updated_post.id # =>  1
updated_post.title # =>  'NEW_post_1'
updated_post.content # =>  'this is my NEW first post'



```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
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