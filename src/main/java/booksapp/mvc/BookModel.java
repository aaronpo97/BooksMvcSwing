package booksapp.mvc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import booksapp.domain.Book;

public class BookModel implements AutoCloseable {

    private final Connection _connection;
    final static String DB_URL = "jdbc:sqlite:data/books.db";

    public BookModel() throws SQLException {
        _connection = DriverManager.getConnection(DB_URL);
    }

    public List<Book> findByCountry(String country) throws SQLException {
        String sql = """
                SELECT
                    b.book_name,
                    b.book_description,
                    GROUP_CONCAT(DISTINCT g.genre_name)
                        AS genres,
                    GROUP_CONCAT(DISTINCT ctr.contributor_name || ' (' || ct.type_name || ')')
                        AS contributors,
                    GROUP_CONCAT(DISTINCT c.country_name)
                        AS country_name
                FROM Book b
                LEFT JOIN
                    BookGenre bg ON bg.book_id = b.book_id
                LEFT JOIN
                    Genre g ON bg.genre_id = g.genre_id
                LEFT JOIN
                    BookContributor bc ON bc.book_id = b.book_id
                LEFT JOIN
                    Contributor ctr ON bc.contributor_id = ctr.contributor_id
                LEFT JOIN
                    ContributorType ct ON bc.contributor_type_id = ct.contributor_type_id
                LEFT JOIN
                    ContributorNationality cn ON cn.contributor_id = ctr.contributor_id
                LEFT JOIN
                    Country c ON cn.country_id = c.country_id
                WHERE b.book_id IN (
                    SELECT bc2.book_id
                    FROM BookContributor bc2
                    JOIN ContributorNationality cn2 ON cn2.contributor_id = bc2.contributor_id
                    JOIN Country c2 ON c2.country_id = cn2.country_id
                    WHERE c2.country_name = ?
                )
                GROUP BY
                    b.book_id, b.book_name, b.book_description
                ORDER BY
                    b.book_name
                """;

        List<Book> books = new ArrayList<>();
        try (PreparedStatement statement = _connection.prepareStatement(sql)) {
            statement.setString(1, country);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    books.add(new Book(
                            resultSet.getString("book_name"),
                            resultSet.getString("book_description"),
                            resultSet.getString("genres"),
                            resultSet.getString("contributors"),
                            resultSet.getString("country_name")));
                }
            }
        }
        return books;
    }

    public List<String> findAllCountryNames() throws SQLException {
        String sql = """
                SELECT DISTINCT
                    c.country_name
                FROM
                    Country c
                ORDER BY
                    c.country_name
                """;

        List<String> countries = new ArrayList<>();
        try (PreparedStatement statement = _connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                countries.add(resultSet.getString("country_name"));
            }
        }
        return countries;
    }

    @Override
    public void close() throws SQLException {
        _connection.close();
    }
}
