CREATE EXTENSION IF NOT EXISTS pg_trgm;
--SET pg_trgm.similarity_threshold = 0.1;
CREATE INDEX idx_products_trgm ON products USING gin (
    name gin_trgm_ops,
    description gin_trgm_ops,
    brand gin_trgm_ops
    );
