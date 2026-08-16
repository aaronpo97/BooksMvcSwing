package booksapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.swing.*;

import com.formdev.flatlaf.FlatDarculaLaf;
import com.formdev.flatlaf.FlatDarkLaf;

import booksapp.mvc.BookModel;
import booksapp.mvc.BooksController;
import booksapp.mvc.BooksView;

public class BooksApp {

    public static void main(String[] args) {
        try {

            UIManager.setLookAndFeel(new FlatDarculaLaf());

            BookModel model = new BookModel();
            BooksView view = new BooksView();

            new BooksController(view, model);
            
            SwingUtilities.invokeLater(() -> view.setVisible(true));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }
}
