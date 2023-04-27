TRUNCATE TABLE posts RESTART IDENTITY; 

INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('post_1', 'this is my first post', 10, 1);
INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('post_2', 'this is my second post', 20, 1);