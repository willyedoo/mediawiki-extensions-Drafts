-- Schema patch for Drafts (PostgreSQL version)

ALTER TABLE drafts
ALTER COLUMN draft_token TYPE BYTEA;
