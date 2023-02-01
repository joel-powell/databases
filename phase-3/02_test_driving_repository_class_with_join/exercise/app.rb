require_relative "lib/database_connection"
require_relative "lib/cohort_repository"

class Application
  def initialize(database_name, io, cohort_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @cohort_repository = cohort_repository
  end

  def run
    cohort = @cohort_repository.find_with_students(1)

    start_date = Date.parse(cohort.start_date).strftime("%D")

    puts "Cohort: #{cohort.name}"
    puts "Starting: #{start_date}"
    puts "Students:"
    puts cohort.students.map { "- #{_1.name}" }.join("\n")
  end
end

if __FILE__ == $PROGRAM_NAME
  app = Application.new(
    "student_directory_2",
    Kernel,
    CohortRepository.new
  )
  app.run
end
