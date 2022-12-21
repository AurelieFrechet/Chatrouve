CREATE TABLE cats (
  id INTEGER PRIMARY KEY   AUTOINCREMENT,
  size TEXT,
  fluffy INTEGER,
  coat_pattern TEXT,
  coat_color TEXT,
  eyes_color TEXT,
  behavior TEXT,
  comments TEXT,
  location BLOB NOT NULL
  );
