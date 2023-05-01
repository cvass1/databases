require 'tag_repository'

RSpec.describe TagRepository do
  it 'returns all tags for a given post' do
    repo = TagRepository.new

    tags = repo.find_by_post(6)

    expect(tags[0].id).to eq '2'
    expect(tags[0].name).to eq 'travel'

    expect(tags[1].id).to eq '3'
    expect(tags[1].name).to eq 'cooking'


  end
  
end