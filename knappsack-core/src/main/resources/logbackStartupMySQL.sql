BEGIN;
CREATE TABLE IF NOT EXISTS LOGGING_EVENT
  (
    TIMESTMP         BIGINT NOT NULL,
    FORMATTED_MESSAGE  TEXT NOT NULL,
    LOGGER_NAME       VARCHAR(254) NOT NULL,
    LEVEL_STRING      VARCHAR(254) NOT NULL,
    THREAD_NAME       VARCHAR(254),
    REFERENCE_FLAG    SMALLINT,
    ARG0              VARCHAR(254),
    ARG1              VARCHAR(254),
    ARG2              VARCHAR(254),
    ARG3              VARCHAR(254),
    CALLER_FILENAME   VARCHAR(254) NOT NULL,
    CALLER_CLASS      VARCHAR(254) NOT NULL,
    CALLER_METHOD     VARCHAR(254) NOT NULL,
    CALLER_LINE       CHAR(4) NOT NULL,
    EVENT_ID          BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY
  );
COMMIT;

BEGIN;
CREATE TABLE IF NOT EXISTS LOGGING_EVENT_PROPERTY
  (
    EVENT_ID	      BIGINT NOT NULL,
    MAPPED_KEY        VARCHAR(254) NOT NULL,
    MAPPED_VALUE      TEXT,
    PRIMARY KEY(EVENT_ID, MAPPED_KEY),
    FOREIGN KEY (EVENT_ID) REFERENCES LOGGING_EVENT(EVENT_ID)
  );
COMMIT;

BEGIN;
CREATE TABLE IF NOT EXISTS LOGGING_EVENT_EXCEPTION
  (
    EVENT_ID         BIGINT NOT NULL,
    I                SMALLINT NOT NULL,
    TRACE_LINE       VARCHAR(254) NOT NULL,
    PRIMARY KEY(EVENT_ID, I),
    FOREIGN KEY (EVENT_ID) REFERENCES LOGGING_EVENT(EVENT_ID)
  );
COMMIT;