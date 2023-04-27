require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it 'gets all posts' do

  repo = PostRepository.new

  posts = repo.all

  expect(posts.length).to eq   2

  expect(posts[0].id).to eq   1
  expect(posts[0].title).to eq   'post_1'
  expect(posts[0].content).to eq   'this is my first post'
  expect(posts[0].number_of_views).to eq  10
  expect(posts[0].user_account_id ).to eq 1


  expect(posts[1].id).to eq   2
  expect(posts[1].title).to eq   'post_2'
  expect(posts[1].content).to eq   'this is my second post'
  expect(posts[1].number_of_views).to eq  20
  expect(posts[1].user_account_id).to eq  1


  end

  it 'returns a single post' do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq  1
    expect(post.title).to eq  'post_1'
    expect(post.content).to eq  'this is my first post'
    expect(post.number_of_views).to eq 10
    expect(post.user_account_id).to eq 1

  end

  it 'creates a new post' do
    repo = PostRepository.new

    post = Post.new

    post.title = 'post_3'
    post.content = 'this is my third post'
    post.number_of_views = 30
    post.user_account_id = 2

    repo.create(post)

    last_post = repo.all.last

    expect(last_post.id).to eq 3
    expect(last_post.title).to eq 'post_3'
    expect(last_post.content).to eq'this is my third post'
    expect(last_post.number_of_views).to eq 30
    expect(last_post.user_account_id).to eq 2

  end

  it 'deletes a post' do
    repo = PostRepository.new

    repo.delete(2)

    expect(repo.all.length).to eq 1
    last_post = repo.all.last
    expect(last_post.id).to eq 1
    expect(last_post.title).to eq 'post_1'
    expect(last_post.content).to eq'this is my first post'
    expect(last_post.number_of_views).to eq 10
    expect(last_post.user_account_id).to eq 1

  end

  it 'updates a post' do
    repo = PostRepository.new

    post = repo.find(1)

    post.title = 'NEW_post_1'
    post.content = 'this is my NEW first post'

    repo.update(post)

    updated_post = repo.find(1)

    expect(updated_post.id).to eq 1
    expect(updated_post.title).to eq 'NEW_post_1'
    expect(updated_post.content).to eq 'this is my NEW first post'

  end
end