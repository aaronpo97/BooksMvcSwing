PRAGMA foreign_keys = ON;

-- ============================================
-- Books Database DDL
-- ============================================

CREATE TABLE Country (
    country_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    country_name    VARCHAR(100) NOT NULL,
    UNIQUE (country_name)
);

CREATE TABLE Author (
    author_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    author_name     VARCHAR(150) NOT NULL
);

CREATE TABLE AuthorNationality (
    author_nationality_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    author_id               INTEGER NOT NULL,
    country_id               INTEGER NOT NULL,
    UNIQUE (author_id, country_id),
    CONSTRAINT fk_authornationality_author
        FOREIGN KEY (author_id) REFERENCES Author(author_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_authornationality_country
        FOREIGN KEY (country_id) REFERENCES Country(country_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Genre (
    genre_id        INTEGER PRIMARY KEY AUTOINCREMENT,
    genre_name      VARCHAR(100) NOT NULL,
    UNIQUE (genre_name)
);

CREATE TABLE Book (
    book_id             INTEGER PRIMARY KEY AUTOINCREMENT,
    book_name           VARCHAR(255) NOT NULL,
    book_description    TEXT NULL
);

CREATE TABLE BookAuthor (
    book_author_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id                 INTEGER NOT NULL,
    author_id               INTEGER NOT NULL,
    contribution_description VARCHAR(500) NULL,
    UNIQUE (book_id, author_id),
    CONSTRAINT fk_bookauthor_book
        FOREIGN KEY (book_id) REFERENCES Book(book_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_bookauthor_author
        FOREIGN KEY (author_id) REFERENCES Author(author_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE BookGenre (
    book_genre_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id         INTEGER NOT NULL,
    genre_id        INTEGER NOT NULL,
    UNIQUE (book_id, genre_id),
    CONSTRAINT fk_bookgenre_book
        FOREIGN KEY (book_id) REFERENCES Book(book_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_bookgenre_genre
        FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================
-- Expanded Sample Data Inserts
-- ============================================

-- Country
INSERT INTO Country (country_name) VALUES
('United Kingdom'),
('United States'),
('Colombia'),
('Japan'),
('Nigeria'),
('France'),
('Russia'),
('Germany'),
('Chile'),
('Canada'),
('India'),
('Ireland'),
('South Africa'),
('Italy'),
('Spain'),
('Egypt'),
('Brazil'),
('China'),
('Turkey'),
('Mexico'),
('Australia');

-- Author
INSERT INTO Author (author_name) VALUES
('George Orwell'),
('Ernest Hemingway'),
('Gabriel Garcia Marquez'),
('Haruki Murakami'),
('Chimamanda Ngozi Adichie'),
('Albert Camus'),
('Fyodor Dostoevsky'),
('Franz Kafka'),
('Isabel Allende'),
('Margaret Atwood'),
('Arundhati Roy'),
('James Joyce'),
('J.M. Coetzee'),
('Italo Calvino'),
('Carlos Ruiz Zafon'),
('Naguib Mahfouz'),
('Jorge Amado'),
('Lu Xun'),
('Orhan Pamuk'),
('Juan Rulfo'),
('Virginia Woolf'),
('F. Scott Fitzgerald'),
('Kazuo Ishiguro'),
('Wole Soyinka'),
('Victor Hugo'),
('Leo Tolstoy'),
('Thomas Mann'),
('Toni Morrison'),
('Salman Rushdie'),
('Agatha Christie');

-- AuthorNationality (many-to-many: an author may hold more than one nationality)
INSERT INTO AuthorNationality (author_id, country_id) VALUES
(1, 1),   -- George Orwell: United Kingdom
(2, 2),   -- Ernest Hemingway: United States
(3, 3),   -- Gabriel Garcia Marquez: Colombia
(4, 4),   -- Haruki Murakami: Japan
(5, 5),   -- Chimamanda Ngozi Adichie: Nigeria
(6, 6),   -- Albert Camus: France
(7, 7),   -- Fyodor Dostoevsky: Russia
(8, 8),   -- Franz Kafka: Germany
(9, 9),   -- Isabel Allende: Chile
(9, 2),   -- Isabel Allende: United States (naturalized)
(10, 10), -- Margaret Atwood: Canada
(11, 11), -- Arundhati Roy: India
(12, 12), -- James Joyce: Ireland
(13, 13), -- J.M. Coetzee: South Africa
(13, 21), -- J.M. Coetzee: Australia (naturalized)
(14, 14), -- Italo Calvino: Italy
(15, 15), -- Carlos Ruiz Zafon: Spain
(16, 16), -- Naguib Mahfouz: Egypt
(17, 17), -- Jorge Amado: Brazil
(18, 18), -- Lu Xun: China
(19, 19), -- Orhan Pamuk: Turkey
(20, 20), -- Juan Rulfo: Mexico
(21, 1),  -- Virginia Woolf: United Kingdom
(22, 2),  -- F. Scott Fitzgerald: United States
(23, 4),  -- Kazuo Ishiguro: Japan (born)
(23, 1),  -- Kazuo Ishiguro: United Kingdom (naturalized)
(24, 5),  -- Wole Soyinka: Nigeria
(25, 6),  -- Victor Hugo: France
(26, 7),  -- Leo Tolstoy: Russia
(27, 8),  -- Thomas Mann: Germany
(28, 2),  -- Toni Morrison: United States
(29, 11), -- Salman Rushdie: India
(30, 1);  -- Agatha Christie: United Kingdom

-- Genre
INSERT INTO Genre (genre_name) VALUES
('Dystopian Fiction'),
('Literary Fiction'),
('Magical Realism'),
('Historical Fiction'),
('Short Story'),
('Science Fiction'),
('Fantasy'),
('Mystery'),
('Romance'),
('Horror'),
('Crime Fiction'),
('Adventure'),
('Satire'),
('Biography'),
('Poetry');

-- Book
INSERT INTO Book (book_name, book_description) VALUES
('1984', 'A dystopian novel set in a totalitarian society under constant surveillance.'),
('Animal Farm', 'A satirical allegory of the Russian Revolution told through farm animals.'),
('The Old Man and the Sea', 'A short novel about an aging fisherman and his struggle with a giant marlin.'),
('A Farewell to Arms', 'A novel set during World War I following an American ambulance driver.'),
('One Hundred Years of Solitude', 'A multi-generational story of the Buendia family in the fictional town of Macondo.'),
('Love in the Time of Cholera', 'A tale of love that endures across five decades.'),
('Norwegian Wood', 'A nostalgic story of loss and burgeoning sexuality set in 1960s Tokyo.'),
('Kafka on the Shore', 'A surreal narrative weaving together two seemingly unrelated stories.'),
('Half of a Yellow Sun', 'A novel set during the Nigerian Civil War, following several intertwined lives.'),
('Americanah', 'A story exploring race, identity, and love across continents.'),
('The Stranger', 'A novel exploring absurdism through the eyes of an indifferent narrator.'),
('The Plague', 'An allegorical novel about a plague sweeping through a North African town.'),
('Crime and Punishment', 'A psychological exploration of guilt following a murder in St. Petersburg.'),
('The Brothers Karamazov', 'A philosophical novel about faith, doubt, and family conflict.'),
('The Trial', 'A man is arrested and prosecuted by a remote, inaccessible authority.'),
('The Metamorphosis', 'A travelling salesman wakes to find himself transformed into a giant insect.'),
('The House of the Spirits', 'A multi-generational saga blending politics and the supernatural.'),
('Eva Luna', 'The story of a woman who becomes a gifted storyteller.'),
('The Handmaid''s Tale', 'A dystopian novel set in a totalitarian society that subjugates women.'),
('Oryx and Crake', 'A speculative novel exploring bioengineering and societal collapse.'),
('The God of Small Things', 'A story of forbidden love and family tragedy in Kerala, India.'),
('Ulysses', 'A modernist novel following a day in the life of Leopold Bloom in Dublin.'),
('Dubliners', 'A collection of short stories depicting middle-class life in early 1900s Dublin.'),
('Disgrace', 'A novel exploring morality and redemption in post-apartheid South Africa.'),
('Invisible Cities', 'A series of prose poems describing fantastical cities to an emperor.'),
('The Shadow of the Wind', 'A young boy discovers a mysterious book that changes his life.'),
('Palace Walk', 'A family saga set in Cairo during British occupation.'),
('Gabriela, Clove and Cinnamon', 'A romance set in a small Brazilian coastal town.'),
('Diary of a Madman', 'A short story satirizing traditional Chinese society.'),
('My Name Is Red', 'A murder mystery set among miniaturist painters in the Ottoman court.'),
('Pedro Paramo', 'A man travels to a ghost town to find the father he never knew.'),
('Mrs Dalloway', 'A single day in the life of a woman preparing for a party in London.'),
('To the Lighthouse', 'A meditative novel exploring family and the passage of time.'),
('The Great Gatsby', 'A novel of wealth, obsession, and the American Dream in the Jazz Age.'),
('Tender Is the Night', 'A story of a psychiatrist and his wife unravelling on the French Riviera.'),
('Never Let Me Go', 'A haunting story of childhood friends confronting a dark shared fate.'),
('The Remains of the Day', 'A butler reflects on a life of duty and missed opportunity.'),
('Death and the King''s Horseman', 'A play exploring colonial interference in Yoruba tradition.'),
('Les Miserables', 'An epic tale of redemption set against the backdrop of 19th-century France.'),
('The Hunchback of Notre-Dame', 'A tragic tale centred on a bell-ringer in medieval Paris.'),
('War and Peace', 'An epic chronicle of Russian society during the Napoleonic Wars.'),
('Anna Karenina', 'A tragic story of adultery and societal judgement in Imperial Russia.'),
('Death in Venice', 'A novella exploring obsession and beauty in early 20th-century Venice.'),
('Beloved', 'A former slave is haunted by the ghost of her deceased daughter.'),
('Song of Solomon', 'A novel following a man''s search for identity and heritage.'),
('Midnight''s Children', 'A story of children born at the moment of India''s independence.'),
('The Satanic Verses', 'A novel exploring identity and faith through magical realist storytelling.'),
('Murder on the Orient Express', 'A detective investigates a murder aboard a snowbound train.'),
('And Then There Were None', 'Ten strangers are lured to an island and killed one by one.');

-- BookAuthor
INSERT INTO BookAuthor (book_id, author_id, contribution_description) VALUES
(1, 1, 'Sole author'),
(2, 1, 'Sole author'),
(3, 2, 'Sole author'),
(4, 2, 'Sole author'),
(5, 3, 'Sole author'),
(6, 3, 'Sole author'),
(7, 4, 'Sole author'),
(8, 4, 'Sole author'),
(9, 5, 'Sole author'),
(10, 5, 'Sole author'),
(11, 6, 'Sole author'),
(12, 6, 'Sole author'),
(13, 7, 'Sole author'),
(14, 7, 'Sole author'),
(15, 8, 'Sole author'),
(16, 8, 'Sole author'),
(17, 9, 'Sole author'),
(18, 9, 'Sole author'),
(19, 10, 'Sole author'),
(20, 10, 'Sole author'),
(21, 11, 'Sole author'),
(22, 12, 'Sole author'),
(23, 12, 'Sole author'),
(24, 13, 'Sole author'),
(25, 14, 'Sole author'),
(26, 15, 'Sole author'),
(27, 16, 'Sole author'),
(28, 17, 'Sole author'),
(29, 18, 'Sole author'),
(30, 19, 'Sole author'),
(31, 20, 'Sole author'),
(32, 21, 'Sole author'),
(33, 21, 'Sole author'),
(34, 22, 'Sole author'),
(35, 22, 'Sole author'),
(36, 23, 'Sole author'),
(37, 23, 'Sole author'),
(38, 24, 'Sole author'),
(39, 25, 'Sole author'),
(40, 25, 'Sole author'),
(41, 26, 'Sole author'),
(42, 26, 'Sole author'),
(43, 27, 'Sole author'),
(44, 28, 'Sole author'),
(45, 28, 'Sole author'),
(46, 29, 'Sole author'),
(47, 29, 'Sole author'),
(48, 30, 'Sole author'),
(49, 30, 'Sole author');

-- BookGenre
INSERT INTO BookGenre (book_id, genre_id) VALUES
(1, 1),
(1, 2),
(2, 13),
(2, 1),
(3, 2),
(3, 5),
(4, 4),
(4, 2),
(5, 3),
(5, 4),
(6, 9),
(6, 3),
(7, 2),
(7, 9),
(8, 3),
(8, 7),
(9, 4),
(9, 2),
(10, 2),
(10, 9),
(11, 2),
(11, 8),
(12, 2),
(12, 4),
(13, 11),
(13, 2),
(14, 2),
(15, 1),
(15, 8),
(16, 5),
(16, 7),
(17, 3),
(17, 4),
(18, 3),
(18, 9),
(19, 1),
(19, 6),
(20, 6),
(20, 1),
(21, 2),
(22, 2),
(23, 5),
(23, 2),
(24, 2),
(25, 7),
(25, 15),
(26, 8),
(26, 4),
(27, 4),
(28, 9),
(28, 4),
(29, 5),
(29, 13),
(30, 8),
(30, 4),
(31, 3),
(32, 2),
(33, 2),
(34, 2),
(34, 9),
(35, 2),
(36, 6),
(36, 2),
(37, 2),
(37, 4),
(38, 4),
(39, 4),
(39, 12),
(40, 4),
(40, 9),
(41, 4),
(41, 2),
(42, 9),
(42, 2),
(43, 2),
(43, 5),
(44, 4),
(44, 2),
(45, 2),
(46, 3),
(46, 4),
(47, 3),
(47, 7),
(48, 8),
(48, 11),
(49, 8),
(49, 11);