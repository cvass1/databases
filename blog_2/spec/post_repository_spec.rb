require 'post_repository'

RSpec.describe PostRepository do
  it 'finds all the posts with a given tag' do
    repo = PostRepository.new

    results = repo.find_by_tag('coding')

    expect(results[0].id).to eq '1'
    expect(results[0].title).to eq 'How to use Git'
    
    expect(results[1].id).to eq '2'
    expect(results[1].title).to eq 'Ruby classes'
    
    expect(results[2].id).to eq '3'
    expect(results[2].title).to eq 'Using IRB'

    expect(results[3].id).to eq '7'
    expect(results[3].title).to eq 'SQL basics'

  end

end