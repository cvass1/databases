require_relative 'database_connection'
require_relative 'user_account'

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts;

    sql = 'SELECT id, email_address, username FROM user_accounts;'

    result_set = DatabaseConnection.exec_params(sql,[])

    user_accounts = []

    result_set.each { |record|
      user_account = UserAccount.new
      user_account.id = record['id'].to_i
      user_account.email_address = record['email_address']
      user_account.username = record['username']

      user_accounts << user_account
    }

    return user_accounts
    # Returns an array of UserAccount objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # 'SELECT id, email_address, username FROM user_accounts WHERE id = $1;;

    sql = 'SELECT id, email_address, username FROM user_accounts WHERE id = $1;'
    sql_params = [id]

    record = DatabaseConnection.exec_params(sql,sql_params)[0]

    user_account = UserAccount.new
    user_account.id = record['id'].to_i
    user_account.email_address = record['email_address']
    user_account.username = record['username']

    return user_account
    # Returns a single UserAccount object.
  end

  def create(user_account)
  # adds a new record into the database
  # 'INSERT INTO user_accounts (email_address, username) VALUES ($1, $2);'	

  sql = 'INSERT INTO user_accounts (email_address, username) VALUES ($1, $2);'	
  sql_params = [user_account.email_address, user_account.username]
  
  DatabaseConnection.exec_params(sql,sql_params)

  return nil

  end

  def update(user_account)
  # updates a record in the database
  # 'UPDATE user_accounts SET email_address = $1, username = $2 WHERE id = $3;'
  sql = 'UPDATE user_accounts SET email_address = $1, username = $2 WHERE id = $3;'
  sql_params = [user_account.email_address, user_account.username, user_account.id]
  
  DatabaseConnection.exec_params(sql,sql_params)

  return nil


  end

  def delete(id)
  # deletes a record in the database
  # 'DELETE FROM user_accounts WHERE id = $1;'
  sql = 'DELETE FROM user_accounts WHERE id = $1;'
  sql_params = [id]
  
  DatabaseConnection.exec_params(sql,sql_params)

  return nil

  end
end