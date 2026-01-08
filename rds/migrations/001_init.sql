-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Articles table: stores individual news articles
CREATE TABLE articles (
    id TEXT PRIMARY KEY,
    source TEXT NOT NULL,
    headline TEXT NOT NULL,
    url TEXT NOT NULL,
    published_at TIMESTAMPTZ,
    fetched_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Stories table: stores grouped story clusters
CREATE TABLE stories (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Article-Story mapping table: links articles to stories
CREATE TABLE article_story_map (
    article_id TEXT NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
    story_id TEXT NOT NULL REFERENCES stories(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (article_id, story_id)
);
