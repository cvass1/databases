require 'user_account_repository'
require 'user_account'


def reset_user_account_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserAccountRepository do
  before(:each) do 
    reset_user_account_table
  end

  it 'gets all user accounts' do
    repo = UserAccountRepository.new
  
    user_accounts = repo.all

    expect(user_accounts.length).to eq  2

    expect(user_accounts[0].id).to eq  1
    expect(user_accounts[0].email_address).to eq  'my_email_1@gmail.com'
    expect(user_accounts[0].username).to eq  'my_username_1'

    expect(user_accounts[1].id).to eq  2
    expect(user_accounts[1].email_address).to eq  'my_email_2@gmail.com'
    expect(user_accounts[1].username).to eq  'my_username_2'
  end

  it 'returns a single user account' do
    repo = UserAccountRepository.new

    user_account = repo.find(1)

    expect(user_account.id).to eq  1
    expect(user_account.email_address).to eq  'my_email_1@gmail.com'
    expect(user_account.username).to eq  'my_username_1'
  end

  it 'creates a new user account' do
    repo = UserAccountRepository.new

    user_account = UserAccount.new
    user_account.email_address = 'my_email_3@gmail.com'
    user_account.username = 'my_username_3'

    repo.create(user_account)

    last_user_account = repo.all.last

    expect(last_user_account.id).to eq  3
    expect(last_user_account.email_address).to eq 'my_email_3@gmail.com'
    expect(last_user_account.username).to eq 'my_username_3'
        
  end

  it 'deletes a user_account ' do
    repo = UserAccountRepository.new

    repo.delete(2)

    expect(repo.all.length).to eq 1
    
    last_user_account = repo.all.last

    expect(last_user_account.id).to eq 1
    expect(last_user_account.email_address).to eq 'my_email_1@gmail.com'
    expect(last_user_account.username).to eq 'my_username_1'

  end

  it 'updates a user account' do
    
  repo = UserAccountRepository.new

  user_account = repo.find(1)

  user_account.email_address = 'my_NEW_email_1@gmail.com'
  user_account.username = 'my_NEW_username_1'

  repo.update(user_account)

  updated_user_account = repo.find(1)

  expect(updated_user_account.id).to eq 1
  expect(updated_user_account.email_address).to eq 'my_NEW_email_1@gmail.com'
  expect(updated_user_account.username).to eq 'my_NEW_username_1'

  end


end