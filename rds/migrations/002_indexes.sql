-- Index on articles.published_at for time-based queries
CREATE INDEX idx_articles_published_at ON articles(published_at);

-- Index on article_story_map.story_id for story lookups
CREATE INDEX idx_article_story_map_story_id ON article_story_map(story_id);

-- Index on article_story_map.article_id for article lookups
CREATE INDEX idx_article_story_map_article_id ON article_story_map(article_id);
