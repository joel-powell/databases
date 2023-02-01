require_relative "cohort"
require_relative "student"

class CohortRepository
  def find_with_students(id)
    query = <<~SQL
      SELECT cohorts.id,
             cohorts.name AS "cohort_name",
             cohorts.start_date,
             students.id AS "student_id",
             students.name AS "student_name"
      FROM cohorts
          JOIN students
              ON cohorts.id = students.cohort_id
      WHERE cohorts.id = $1;
    SQL
    params = [id]
    result_set = DatabaseConnection.exec_params(query, params)
    cohort = record_to_cohort_object(result_set.first)
    result_set.each { cohort.students << record_to_student_object(_1) }
    cohort
  end

  private

  def record_to_cohort_object(record)
    cohort = Cohort.new
    cohort.id = record["id"].to_i
    cohort.name = record["cohort_name"]
    cohort.start_date = record["start_date"]
    cohort
  end

  def record_to_student_object(record)
    student = Student.new
    student.id = record["student_id"].to_i
    student.name = record["student_name"]
    student
  end
end
