require_relative './lib/cohort_repository'
require_relative './lib/database_connection'

DatabaseConnection.connect('student_directory_2')

cohort_repo = CohortRepository.new

cohort = cohort_repo.find_with_students(2)

puts "cohort:#{cohort.id}, #{cohort.name}, starting date: #{cohort.starting_date}"



cohort.students.each {|student|
  puts "name: #{student.name}, student ID: #{student.id}"
}