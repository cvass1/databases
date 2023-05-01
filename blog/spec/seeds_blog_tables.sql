TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content) VALUES ('My first post', 'This is the content for my first post');
INSERT INTO posts (title, content) VALUES ('My second post', 'This is the content for my second post');

INSERT INTO comments (content, author_name, post_id) VALUES ('this is the first comment on post 1', 'first poster', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('this is the second comment on post 1', 'second poster', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('this is the first comment on post 2', 'third poster', 2);
INSERT INTO comments (content, author_name, post_id) VALUES ('this is the second comment on post 2', 'forth poster', 2);


