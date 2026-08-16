# BooksMvcSwing

A Java Swing desktop application that browses a SQLite book catalogue by author nationality.

## Why this exists

This is a practice project for implementing the Model-View-Controller pattern in Java Swing with a relational SQLite backend. 

Built alongside coursework in Advanced Java (INFO3136) as an exercise in MVC and database access.

## Status

Experimental and not actively maintained beyond this initial version.

## Requirements

- JDK 21 or later
- Maven 3.6 or later

Runs on any platform with a compatible JDK; verified on Linux.

## Run from source

The database at `data/books.db` ships committed in the repository, so no extra setup is needed before running the application.

```bash
git clone https://github.com/aaronpo97/BooksMvcSwing.git
cd BooksMvcSwing
mvn compile exec:java
```

This opens a window titled "Find" with a country dropdown and a Find button.

## Usage

### Find books by author nationality

1. Select a country from the **Country** dropdown.
2. Select **Find**.


## Database

The application reads from `data/books.db`, an existing SQLite database committed to the repository. 

[book_sqlite.sql](book_sqlite.sql) is the schema and seed script used to build it.

```mermaid
erDiagram
    COUNTRY ||--o{ AUTHOR_NATIONALITY : has
    AUTHOR ||--o{ AUTHOR_NATIONALITY : holds
    AUTHOR ||--o{ BOOK_AUTHOR : writes
    BOOK ||--o{ BOOK_AUTHOR : has
    BOOK ||--o{ BOOK_GENRE : has
    GENRE ||--o{ BOOK_GENRE : has

    COUNTRY {
        int country_id PK
        string country_name
    }
    AUTHOR {
        int author_id PK
        string author_name
    }
    AUTHOR_NATIONALITY {
        int author_nationality_id PK
        int author_id FK
        int country_id FK
    }
    GENRE {
        int genre_id PK
        string genre_name
    }
    BOOK {
        int book_id PK
        string book_name
        string book_description
    }
    BOOK_AUTHOR {
        int book_author_id PK
        int book_id FK
        int author_id FK
        string contribution_description
    }
    BOOK_GENRE {
        int book_genre_id PK
        int book_id FK
        int genre_id FK
    }
```

Rebuild the database from the script with any SQLite client:

```bash
sqlite3 data/books.db < book_sqlite.sql
```


## Architecture

The source under `src/main/java/booksapp` follows an MVC split:

- [BooksApp](src/main/java/booksapp/BooksApp.java) — entry point
- [mvc/BookModel](src/main/java/booksapp/mvc/BookModel.java) — data access layer. Runs the SQL queries against `data/books.db` and maps result sets to `Book` records.
- [mvc/BooksView](src/main/java/booksapp/mvc/BooksView.java) — the `JFrame` UI: a country dropdown, a Find button, and a results table, laid out with `GroupLayout`.
- [mvc/BooksController](src/main/java/booksapp/mvc/BooksController.java) — an `ActionListener` that loads the country list into the view on startup and, on Find, queries the model and pushes results into the table.
- [domain/Book](src/main/java/booksapp/domain/Book.java) — an immutable record (`name`, `description`, `genres`, `authors`, `country`) representing one query result row.

```mermaid
classDiagram
    class BooksApp {
        +main(String[] args) void
    }
    class BooksView {
        -JLabel label
        -JTable _table
        -JComboBox~String~ _selectField
        -JButton _findButton
        +BooksView()
        +trySetTableModel(TableModel) boolean
        +getSelectField() JComboBox~String~
        +getFindButton() JButton
    }
    class BooksController {
        -BooksView _view
        -BookModel _bookModel
        -ArrayList~String~ _countries
        +BooksController(BooksView, BookModel)
        +actionPerformed(ActionEvent) void
    }
    class BookModel {
        -Connection _connection
        +BookModel()
        +findByCountry(String country) List~Book~
        +findAllCountryNames() List~String~
        +close() void
    }
    class Book {
        <<record>>
        +String name
        +String description
        +String genres
        +String authors
        +String country
    }
    class JFrame
    class ActionListener {
        <<interface>>
    }
    class AutoCloseable {
        <<interface>>
    }

    BooksApp ..> BooksView : creates
    BooksApp ..> BookModel : creates
    BooksApp ..> BooksController : creates
    BooksController --> BooksView : controls
    BooksController --> BookModel : queries
    BooksController ..> Book : uses
    BookModel ..> Book : creates
    JFrame <|-- BooksView
    ActionListener <|.. BooksController
    AutoCloseable <|.. BookModel
```

## License

MIT — see [LICENSE](LICENSE).
