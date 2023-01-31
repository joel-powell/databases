require_relative "account"
require_relative "format"

class AccountRepository
  include Format

  def all
    query = <<~SQL
      SELECT * FROM accounts;
    SQL
    result_set = DatabaseConnection.exec_params(query, [])
    result_set.map { Account.new(hash_values_to_integers(_1)) }
  end

  def find(id)
    query = <<~SQL
      SELECT * FROM accounts
      WHERE id = $1;
    SQL
    params = [id]
    result_set = DatabaseConnection.exec_params(query, params)
    record = result_set.first

    Account.new(hash_values_to_integers(record)) unless record.nil?
  end

  def create(account)
    query = <<~SQL
      INSERT INTO accounts (email, username)
      VALUES ($1, $2);
    SQL
    params = [account.email, account.username]
    DatabaseConnection.exec_params(query, params)
  end

  def update(account)
    query = <<~SQL
      UPDATE accounts
      SET email = $2, username = $3
      WHERE id = $1;
    SQL
    params = [account.id, account.email, account.username]
    DatabaseConnection.exec_params(query, params)
  end

  def delete(id)
    query = <<~SQL
      DELETE FROM accounts
      WHERE id = $1;
    SQL
    params = [id]
    DatabaseConnection.exec_params(query, params)
  end
end
