package booksapp.mvc;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;

import booksapp.domain.Book;

public class BooksController implements ActionListener {

    private BooksView _view;
    private BookModel _bookModel;

    private ArrayList<String> _countries = new ArrayList<>();

    /**
     * Registers all button and list-data listeners.
     */
    public BooksController(BooksView view, BookModel bookModel) {

        _view = view;
        _bookModel = bookModel;

        _view.getFindButton().addActionListener(this);
        _view.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                try {
                    _bookModel.close();
                } catch (SQLException ex) {
                    System.out.println("Failed to close connection");
                }
            }
        });

        try {
            loadCountries();
            _view.getSelectField().setModel(new DefaultComboBoxModel<>(_countries.toArray(new String[0])));
        } catch (SQLException ex) {
            System.out.println("Failed to load countries");
        }

    }

    private void loadCountries() throws SQLException {
        _countries = new ArrayList<>(_bookModel.findAllCountryNames());
    }

    private TableModel getBooksByCountry(String country) throws SQLException {
        List<Book> books = _bookModel.findByCountry(country);
        return toTableModel(books);
    }

    private TableModel toTableModel(List<Book> books) {
        Vector<String> columnNames = new Vector<>(List.of("book_name", "book_description", "genres", "authors", "country_name"));
        Vector<Vector<Object>> rows = new Vector<>();

        for (Book book : books) {
            Vector<Object> row = new Vector<>();
            row.add(book.name());
            row.add(book.description());
            row.add(book.genres());
            row.add(book.authors());
            row.add(book.country());
            rows.add(row);
        }

        return new DefaultTableModel(rows, columnNames);
    }

    @Override
    public void actionPerformed(ActionEvent ev) {
        try {
            if (ev.getSource() == _view.getFindButton()) {
                handleFind();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    private void handleFind() throws SQLException {
        Object selected = _view.getSelectField().getSelectedItem();
        if (selected == null) {
            System.out.println("No country selected");
            return;
        }
        String country = selected.toString();
        TableModel model = getBooksByCountry(country);

        _view.trySetTableModel(model);
    }

}
