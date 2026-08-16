package booksapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.swing.*;

import com.formdev.flatlaf.FlatDarkLaf;

import booksapp.mvc.BookModel;
import booksapp.mvc.BooksController;
import booksapp.mvc.BooksView;

public class BooksApp {

    private static final String DB_URL = "jdbc:sqlite:data/books.db";

    public static void main(String[] args) {
        try {
            try {
                UIManager.setLookAndFeel(new FlatDarkLaf());
            } catch (Exception e) {
                e.printStackTrace();
            }

            Connection connection = DriverManager.getConnection(DB_URL);
            BookModel model = new BookModel(connection);
            BooksView view = new BooksView();
            new BooksController(view, model);
            SwingUtilities.invokeLater(() -> view.setVisible(true));
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

    }
}
