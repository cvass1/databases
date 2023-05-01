require_relative 'cohort'
require_relative 'student'


class CohortRepository

  def find_with_students(cohort_id)
    sql = 'SELECT cohorts.id,
                  cohorts.name as cohort_name,
                  cohorts.starting_date,
                  students.id AS student_id,
                  students.name as student_name,
                  students.cohort_id
          FROM cohorts
          JOIN students ON students.cohort_id = cohorts.id
          WHERE cohorts.id = $1;'
    sql_params = [cohort_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)


    cohort = Cohort.new
    cohort.id = result_set.first['id']
    cohort.name = result_set.first['cohort_name']
    cohort.starting_date = result_set.first['starting_date']

    result_set.each {|record|
      student = Student.new
      student.id = record['student_id']
      student.name = record['student_name']
      student.cohort_id = record['cohort_id']

      cohort.students << student
    }
    
    return cohort


  end
end