SELECT tags.id, tags.name
  FROM tags 
    JOIN posts_tags ON posts_tags.tag_id = tags.id
    JOIN posts ON posts_tags.post_id = posts.id
    WHERE posts.id = 2;


-- Exercise One

SELECT posts.id, posts.title
    FROM posts
    JOIN posts_tags ON posts.id = posts_tags.post_id
    JOIN tags ON tags.id = posts_tags.tag_id
    WHERE tags.name = 'travel';

-- Challenge

INSERT INTO tags ("name") VALUES
('sql');

INSERT INTO posts_tags ("post_id", "tag_id") VALUES
(7, 5);

SELECT posts.id, posts.title
    FROM posts
    JOIN posts_tags ON posts.id = posts_tags.post_id
    JOIN tags ON tags.id = posts_tags.tag_id
    WHERE tags.name = 'sql';




