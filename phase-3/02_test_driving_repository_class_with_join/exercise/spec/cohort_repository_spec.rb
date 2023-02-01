require_relative "../lib/cohort_repository"

def reset_tables
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "localhost", dbname: "student_directory_2" })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do
    reset_tables
  end

  describe "#find_with_students" do
    context "given a cohort id of 1" do
      it "returns the cohort object also containing an array of corresponding student objects" do
        cohort_repository = CohortRepository.new
        cohort = cohort_repository.find_with_students(1)

        expected = have_attributes(
          id: 1,
          name: "December 22",
          start_date: "2022-12-05",
          students: [
            have_attributes(id: 1, name: "Alice"),
            have_attributes(id: 4, name: "Dan")
          ]
        )

        expect(cohort).to match(expected)
      end
    end

    context "given a cohort id of 2" do
      it "returns the cohort object also containing an array of corresponding student objects" do
        cohort_repository = CohortRepository.new
        cohort = cohort_repository.find_with_students(2)

        expected = have_attributes(
          id: 2,
          name: "January 23",
          start_date: "2023-01-16",
          students: [
            have_attributes(id: 2, name: "Bob"),
            have_attributes(id: 3, name: "Carry")
          ]
        )

        expect(cohort).to match(expected)
      end
    end
  end
end
