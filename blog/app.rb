require_relative './lib/database_connection'
require_relative './lib/post_repository'


DatabaseConnection.connect('blog')

repo = PostRepository.new

post = repo.find_with_comments(2)

puts "post id: #{post.id}, post title: #{post.title}, post content: #{post.content}"

post.comments.each {|comment|
puts "comment id: #{comment.id}, content: #{comment.content}, author: #{comment.author_name}"
}