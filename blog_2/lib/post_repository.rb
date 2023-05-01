require_relative 'post'
require_relative 'database_connection'

class PostRepository

  def find_by_tag(tag_name)
    sql = 'SELECT posts.id, posts.title
          FROM posts 
          JOIN posts_tags ON posts.id = posts_tags.post_id
          JOIN tags ON tags.id = posts_tags.tag_id
          WHERE tags.name = $1;'
    sql_params = [tag_name]

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    posts = []

    result_set.each { |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']

      posts << post
    }
    return posts

  end

end