require_relative 'post'
require_relative 'database_connection'

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_account_id FROM posts;

    sql = 'SELECT id, title, content, number_of_views, user_account_id FROM posts;'
    sql_params = []

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    posts = []

    result_set.each { |record|
      post = Post.new
      post.id = record['id'].to_i
      post.title = record['title']
      post.content = record['content']
      post.number_of_views = record['number_of_views'].to_i
      post.user_account_id = record['user_account_id'].to_i
      
      posts << post
    }

    return posts

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # 'SELECT title, content, number_of_views, user_account_id WHERE id = $1;'
    sql = 'SELECT id, title, content, number_of_views, user_account_id FROM posts WHERE id = $1;'
    sql_params = [id]

    record = DatabaseConnection.exec_params(sql,sql_params)[0]
    
    post = Post.new
    post.id = record['id'].to_i
    post.title = record['title']
    post.content = record['content']
    post.number_of_views = record['number_of_views'].to_i
    post.user_account_id = record['user_account_id'].to_i

    return post

    # Returns a single Post object.
  end

  def create(post)
  # adds a new record into the database
  # 'INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ($1, $2, $3, $4);'	

  sql = 'INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ($1, $2, $3, $4);'	
  sql_params = [post.title, post.content, post.number_of_views, post.user_account_id]

  DatabaseConnection.exec_params(sql, sql_params)
  
  return nil

  end

  def update(post)
  # updates a record in the database
  # 'UPDATE posts SET title = $1, content = $2, number_of_views = $3, user_account_id =$4 WHERE id = $5;'
  sql = 'UPDATE posts SET title = $1, content = $2, number_of_views = $3, user_account_id =$4 WHERE id = $5;'
  sql_params = [post.title, post.content, post.number_of_views, post.user_account_id, post.id]

  DatabaseConnection.exec_params(sql, sql_params)
  
  return nil


  end

  def delete(id)
  # deletes a record in the database
  # 'DELETE FROM posts WHERE id = $1;'
  sql = 'DELETE FROM posts WHERE id = $1;'
  sql_params = [id]

  DatabaseConnection.exec_params(sql, sql_params)
  
  return nil



  end
end