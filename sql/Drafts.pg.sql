-- SQL for Drafts Extension (PostgreSQL version)
-- Stores working changes to pages that users have yet to commit

BEGIN;

CREATE TABLE drafts (
    draft_id INTEGER PRIMARY KEY DEFAULT nextval('drafts_id_seq'),
    draft_token TEXT,
    draft_user INTEGER NOT NULL DEFAULT 0,
    draft_page INTEGER NOT NULL DEFAULT 0,
    draft_namespace INTEGER NOT NULL,
    draft_title TEXT NOT NULL DEFAULT '',
    draft_section SMALLINT,
    draft_starttime TIMESTAMPTZ,
    draft_edittime TIMESTAMPTZ,
    draft_savetime TIMESTAMPTZ,
    draft_scrolltop INTEGER,
    draft_text TEXT NOT NULL,
    draft_summary TEXT,
    draft_minoredit BOOLEAN
);

-- Create the sequence for draft_id if not already present
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = 'drafts_id_seq') THEN
        CREATE SEQUENCE drafts_id_seq OWNED BY drafts.draft_id;
    END IF;
END
$$;

-- Indexes to optimize queries
CREATE INDEX draft_user_savetime ON drafts (draft_user, draft_savetime);
CREATE INDEX draft_user_page_savetime ON drafts (draft_user, draft_page, draft_namespace, draft_title, draft_savetime);
CREATE INDEX draft_savetime ON drafts (draft_savetime);
CREATE INDEX draft_page ON drafts (draft_page);
CREATE INDEX draft_title_namespace ON drafts (draft_title, draft_namespace);

COMMIT;
