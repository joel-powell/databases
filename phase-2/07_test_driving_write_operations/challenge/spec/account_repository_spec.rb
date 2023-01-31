require_relative "../lib/account_repository"
require_relative "reset_tables"

describe AccountRepository do
  before(:each) do
    reset_tables
  end

  describe "#all" do
    it "returns all accounts" do
      repo = AccountRepository.new

      accounts = repo.all

      expect(accounts.length).to eq(2)

      expected = [
        have_attributes(
          id: 1,
          email: "test@email.com",
          username: "user_one"
        ),
        have_attributes(
          id: 2,
          email: "email@testing.co.uk",
          username: "user_two"
        )
      ]

      expect(accounts).to match_array(expected)
    end
  end

  describe "#find" do
    context "given an id of 1" do
      it "returns the account with id 1" do
        repo = AccountRepository.new

        account = repo.find(1)

        expected = have_attributes(
          id: 1,
          email: "test@email.com",
          username: "user_one"
        )

        expect(account).to match(expected)
      end
    end
  end

  describe "#create" do
    context "given a new account object" do
      it "adds the account to the database" do
        repo = AccountRepository.new

        new_account = Account.new(email: "test_new@email.co.uk", username: "new_user")

        repo.create(new_account)

        expect(repo.all).to include(have_attributes(new_account.to_h.except(:id)))
      end
    end
  end

  describe "#update" do
    context "given an updated account object" do
      it "updates the record with the given id to the new values" do
        repo = AccountRepository.new

        updated_account = Account.new(id: 2, email: "updated_email@testing.co.uk", username: "updated_user")

        repo.update(updated_account)

        account = repo.find(2)

        expected = have_attributes(
          id: 2,
          email: "updated_email@testing.co.uk",
          username: "updated_user"
        )

        expect(account).to match(expected)
      end
    end
  end

  describe "#delete" do
    context "given an id of 1" do
      it "deletes the account with id 1" do
        repo = AccountRepository.new

        repo.delete(1)

        expect(repo.find(1)).to eq nil
      end
    end
  end
end
