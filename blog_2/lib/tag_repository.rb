require_relative 'tag'

class TagRepository
  def find_by_post(post_id)
    sql = 'SELECT tags.id, tags.name
          FROM tags 
          JOIN posts_tags ON tags.id = posts_tags.tag_id
          JOIN posts ON posts.id = posts_tags.post_id
          WHERE posts.id = $1;'
    sql_params = [post_id]

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    tags = []

    result_set.each { |record|
      tag = Tag.new
      tag.id = record['id']
      tag.name = record['name']

      tags << tag
    }

    return tags

  end
end