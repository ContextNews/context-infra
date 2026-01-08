# Context Database

PostgreSQL database for the Context news aggregation system. Stores articles, story clusters, and their relationships.

## Schema

### `articles`
Individual news articles ingested from various sources.
- `id`: Unique article identifier
- `source`: Origin feed/publisher
- `headline`: Article headline
- `url`: Source URL (unique constraint)
- `published_at`: Original publication timestamp
- `fetched_at`: When the article was ingested

### `stories`
Grouped clusters of related articles representing a single news story.
- `id`: Unique story identifier
- `title`: Generated story headline

### `article_story_map`
Many-to-many relationship linking articles to stories. An article can belong to multiple stories; a story contains multiple articles.

## Migrations

Migrations are forward-only. Never modify or delete existing migration files.

To add schema changes:
1. Create a new numbered migration file (e.g., `004_*.sql`)
2. Use `ALTER TABLE` or `CREATE` statements
3. Test against a local Postgres instance before applying to production

Run migrations in order using `psql` or your preferred migration runner.

## Service Access

| Service | Access |
|---------|--------|
| Ingestion | Write: `articles` |
| Clustering | Read: `articles`, Write: `stories`, `article_story_map` |
| API | Read: all tables |
