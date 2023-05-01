require 'post'
require 'comment'
require 'post_repository'

def reset_blog_tables
  seed_sql = File.read('spec/seeds_blog_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do 
    reset_blog_tables
  end

  it 'returns one post and prints its comments' do
    repo = PostRepository.new

    post = repo.find_with_comments(1)

    expect(post.id).to eq '1'
    expect(post.title).to eq 'My first post'
    expect(post.content).to eq 'This is the content for my first post'

    expect(post.comments.length).to eq 2
    expect(post.comments[0].id).to eq '1'
    expect(post.comments[0].content).to eq 'this is the first comment on post 1'
    expect(post.comments[0].author_name).to eq 'first poster'
    expect(post.comments[0].post_id).to eq '1'

    expect(post.comments[1].id).to eq '2'
    expect(post.comments[1].content).to eq 'this is the second comment on post 1'
    expect(post.comments[1].author_name).to eq 'second poster'
    expect(post.comments[1].post_id).to eq '1'

    
  end
end