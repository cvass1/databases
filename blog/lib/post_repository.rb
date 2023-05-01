require_relative 'post'
require_relative 'comment'


class PostRepository
def find_with_comments(post_id)
  sql = 'SELECT posts.id AS post_id,
                posts.title,
                posts.content AS post_content,
                comments.id AS comment_id,
                comments.content AS comment_content,
                comments.author_name,
                comments.post_id
                FROM posts
                JOIN comments ON posts.id = comments.post_id
                WHERE posts.id = $1'
  
  sql_params = [post_id]

  result = DatabaseConnection.exec_params(sql,sql_params)

  post = Post.new
  post.id = result.first['post_id']
  post.title = result.first['title']
  post.content = result.first['post_content']

  result.each { |record|
  comment = Comment.new
  comment.id = record['comment_id']
  comment.content = record["comment_content"]
  comment.author_name = record["author_name"]
  comment.post_id = record["post_id"]

  post.comments << comment

  }

  return post

end

end
