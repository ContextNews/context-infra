-- Unique constraint on articles.url to prevent duplicate articles
ALTER TABLE articles ADD CONSTRAINT articles_url_unique UNIQUE (url);
