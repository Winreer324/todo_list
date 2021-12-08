
part of database;

const String _createTableTask = '''
CREATE TABLE Task (
id INTEGER PRIMARY KEY,
categoryId INTEGER,
name TEXT not null,
description TEXT NULL,
dateStart DATETIME NULL,
dateEnd DATETIME NULL,
isComplete BIT DEFAULT 1
)
''';
//categoryId INTEGER FOREIGN KEY Category(id),
const String _createTableCategory = '''
CREATE TABLE Category (
id INTEGER PRIMARY KEY,
name TEXT not null,
description TEXT,
countTasks INTEGER DEFAULT 0
)
''';