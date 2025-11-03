-- SQL for Drafts Extension (PostgreSQL version)

CREATE TABLE drafts (
    draft_id SERIAL PRIMARY KEY,
    draft_token BYTEA,
    draft_user INTEGER NOT NULL DEFAULT 0,
    draft_page INTEGER NOT NULL DEFAULT 0,
    draft_namespace INTEGER NOT NULL,
    draft_title BYTEA NOT NULL DEFAULT '',
    draft_section INTEGER,
    draft_starttime BYTEA,
    draft_edittime BYTEA,
    draft_savetime BYTEA,
    draft_scrolltop INTEGER,
    draft_text BYTEA NOT NULL,
    draft_summary BYTEA,
    draft_minoredit BOOLEAN
);

CREATE INDEX draft_user_savetime ON drafts (draft_user, draft_savetime);
CREATE INDEX draft_user_page_savetime ON drafts (draft_user, draft_page, draft_namespace, draft_title, draft_savetime);
CREATE INDEX draft_savetime ON drafts (draft_savetime);
CREATE INDEX draft_page ON drafts (draft_page);
CREATE INDEX draft_title ON drafts (draft_title, draft_namespace);
