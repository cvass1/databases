require 'cohort'
require 'student'
require 'cohort_repository'

RSpec.describe CohortRepository do
  it 'finds a cohort and returns a list of its students' do
    repo = CohortRepository.new
    cohort = Cohort.new

    cohort = repo.find_with_students(1)

    result = cohort.students

    expect(result[0].id).to eq '1'
    expect(result[0].name).to eq 'student 1'
    expect(result[0].cohort_id).to eq '1'

    expect(result[1].id).to eq '2'
    expect(result[1].name).to eq 'student 2'
    expect(result[1].cohort_id).to eq '1'
  end
end