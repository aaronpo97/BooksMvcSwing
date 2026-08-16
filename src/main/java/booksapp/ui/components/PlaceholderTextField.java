package booksapp.ui.components;

import java.awt.Color;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Insets;

import javax.swing.JTextField;


public class PlaceholderTextField extends JTextField
{

   private final String placeholder_;

   public PlaceholderTextField(String placeholder)
   {
      placeholder_ = placeholder;
   }

   @Override
   protected void paintComponent(Graphics g)
   {
      super.paintComponent(g);

      if (!getText().isEmpty() || placeholder_ == null)
      {
         return;
      }

      Graphics2D g2 = (Graphics2D) g.create();
      g2.setColor(Color.GRAY);
      g2.setFont(getFont());

      FontMetrics fm = g2.getFontMetrics();
      Insets insets = getInsets();
      int x = insets.left;
      int y = (getHeight() - fm.getHeight()) / 2 + fm.getAscent();

      g2.drawString(placeholder_, x, y);
      g2.dispose();
   }
}
