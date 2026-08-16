package booksapp.mvc;

import static javax.swing.GroupLayout.Alignment.BASELINE;
import static javax.swing.GroupLayout.Alignment.LEADING;

import java.awt.*;

import javax.swing.*;
import javax.swing.table.TableModel;

public class BooksView extends JFrame {
    private JLabel label = new JLabel("Country");
    private JTable _table = new JTable();
    private JComboBox<String> _selectField = new JComboBox<>();
    private JButton _findButton = new JButton("Find");

    public BooksView() {
        JScrollPane tableScrollPane = new JScrollPane(_table);

        GroupLayout layout = new GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setAutoCreateGaps(true);
        layout.setAutoCreateContainerGaps(true);

        layout.setHorizontalGroup(layout.createParallelGroup(LEADING).addGroup(layout.createSequentialGroup().addComponent(label).addComponent(_selectField).addComponent(_findButton)).addComponent(tableScrollPane));


        layout.setVerticalGroup(layout.createSequentialGroup().addGroup(layout.createParallelGroup(BASELINE).addComponent(label).addComponent(_selectField).addComponent(_findButton)).addComponent(tableScrollPane));

        setTitle("Find");
        setSize(getWindowSize());
        setLocationRelativeTo(null);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
    }

    public boolean trySetTableModel(TableModel tableModel) {
        try {
            _table.setModel(tableModel);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public JComboBox<String> getSelectField() {
        return _selectField;
    }

    public JButton getFindButton() {
        return _findButton;
    }

    private Dimension getWindowSize() {
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        int width = screenSize.width / 2;
        int height = screenSize.height / 2;

        return new Dimension(width, height);
    }
}