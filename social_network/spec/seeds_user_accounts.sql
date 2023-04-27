TRUNCATE TABLE posts, user_accounts RESTART IDENTITY; 

INSERT INTO user_accounts (email_address, username) VALUES ('my_email_1@gmail.com', 'my_username_1');
INSERT INTO user_accounts (email_address, username) VALUES ('my_email_2@gmail.com', 'my_username_2');

INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('post_1', 'this is my first post', 10, 1);
INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('post_2', 'this is my second post', 20, 1);