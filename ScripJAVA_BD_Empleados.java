import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableRowSorter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class ScripJAVA_BD_Empleados {
    private static final String URL = "jdbc:postgresql://localhost:5432/base";
    private static final String USER = "postgres";
    private static final String PASSWORD = "root234";

    private JTextField tfCodigo, tfApellido1, tfApellido2, tfNombre1, tfNombre2, tfFechaNacimiento, tfEmail, tfDireccion, tfSueldo, tfCuenta;
    private JComboBox<String> cbSexo, cbTipoSangre, cbBanco;
    private JLabel lblPhoto;
    private JButton btnAdd, btnUpdate, btnCancel, btnUploadPhoto;
    private String photoPath;

    public ScripJAVA_BD_Empleados() {
        JFrame frame = new JFrame();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(600, 700);

        JPanel panel = new JPanel(new BorderLayout());
        panel.setBackground(Color.LIGHT_GRAY);

        JLabel titleLabel = new JLabel("CODE CARLOS", SwingConstants.CENTER);
        titleLabel.setFont(new Font("Arial", Font.BOLD, 24));
        titleLabel.setOpaque(true);
        titleLabel.setBackground(Color.LIGHT_GRAY);
        panel.add(titleLabel, BorderLayout.NORTH);

        JPanel panelLeft = new JPanel(new GridBagLayout());
        panelLeft.setBackground(Color.LIGHT_GRAY);
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.insets = new Insets(5, 5, 5, 5);

        addLabelAndField(panelLeft, gbc, "EMPCODIGO:", tfCodigo = new JTextField(), 0);
        addLabelAndField(panelLeft, gbc, "EMPAPELLIDO1:", tfApellido1 = new JTextField(), 1);
        addLabelAndField(panelLeft, gbc, "EMPAPELLIDO2:", tfApellido2 = new JTextField(), 2);
        addLabelAndField(panelLeft, gbc, "EMPNOMBRE1:", tfNombre1 = new JTextField(), 3);
        addLabelAndField(panelLeft, gbc, "EMPNOMBRE2:", tfNombre2 = new JTextField(), 4);
        addLabelAndField(panelLeft, gbc, "EMPFECHANACIMIENTO:", tfFechaNacimiento = new JTextField(), 5);

        // Adding JComboBox for EMPSEXO
        addLabelAndField(panelLeft, gbc, "EMPSEXO:", cbSexo = new JComboBox<>(new String[]{"H", "M", "OTROS"}), 6);
        addLabelAndField(panelLeft, gbc, "EMPEMAIL:", tfEmail = new JTextField(), 7);
        addLabelAndField(panelLeft, gbc, "EMPDIRECCION:", tfDireccion = new JTextField(), 8);

        // Adding JComboBox for EMPTIPOSANGRE
        addLabelAndField(panelLeft, gbc, "EMPTIPOSANGRE:", cbTipoSangre = new JComboBox<>(new String[]{"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-", "RH-", "RH+", "Otros"}), 9);
        addLabelAndField(panelLeft, gbc, "EMPSUELDO:", tfSueldo = new JTextField(), 10);

        // Adding JComboBox for EMPBANCO
        addLabelAndField(panelLeft, gbc, "EMPBANCO:", cbBanco = new JComboBox<>(new String[]{"BANCO DEL PACÍFICO", "BANCO PICHINCHA", "BANCO GUAYAQUIL", "BANCO DE LOJA", "BANCO DEL AUSTRO", "BANCO INTERNACIONAL", "BANCO BOLIVARIANO", "BANCO PRODUBANCO", "BANCO DE MACHALA", "BANCO SOLIDARIO", "BANCO DE FOMENTO", "BANCO PROCREDIT", "BANCO AMAZONAS", "BANCO DEL LITORAL", "Otros"}), 11);
        addLabelAndField(panelLeft, gbc, "EMPCUENTA:", tfCuenta = new JTextField(), 12);

        // EMPSTATUS fixed to ACT
        gbc.gridx = 0;
        gbc.gridy = 13;
        panelLeft.add(new JLabel("EMPSTATUS:"), gbc);
        gbc.gridx = 1;
        JTextField tfStatus = new JTextField("ACT");
        tfStatus.setEditable(false);
        panelLeft.add(tfStatus, gbc);

        gbc.gridx = 0;
        gbc.gridy = 14;
        panelLeft.add(new JLabel("EMPFOTO:"), gbc);

        gbc.gridx = 1;
        lblPhoto = new JLabel();
        lblPhoto.setPreferredSize(new Dimension(100, 100));
        panelLeft.add(lblPhoto, gbc);

        gbc.gridx = 2;
        btnUploadPhoto = new JButton("Cargar Foto");
        btnUploadPhoto.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                uploadPhoto();
            }
        });
        panelLeft.add(btnUploadPhoto, gbc);

        gbc.gridx = 0;
        gbc.gridy = 15;
        gbc.gridwidth = 1;
        btnAdd = new JButton("Agregar");
        btnAdd.setBackground(Color.GREEN);
        btnAdd.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (validateFields()) {
                    addEmployee();
                }
            }
        });
        panelLeft.add(btnAdd, gbc);

        gbc.gridx = 1;
        btnUpdate = new JButton("Actualizar");
        btnUpdate.setBackground(Color.BLUE);
        btnUpdate.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (validateFields()) {
                    updateEmployee();
                }
            }
        });
        panelLeft.add(btnUpdate, gbc);

        gbc.gridx = 2;
        btnCancel = new JButton("Cancelar");
        btnCancel.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                clearFields();
            }
        });
        panelLeft.add(btnCancel, gbc);

        gbc.gridx = 3;
        JButton btnTable = new JButton("Tabla");
        btnTable.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new EmployeeTable();
            }
        });
        panelLeft.add(btnTable, gbc);

        panel.add(panelLeft, BorderLayout.CENTER);
        frame.add(panel);
        frame.setVisible(true);
    }

    private void addLabelAndField(JPanel panel, GridBagConstraints gbc, String label, JComponent component, int y) {
        gbc.gridx = 0;
        gbc.gridy = y;
        panel.add(new JLabel(label), gbc);

        gbc.gridx = 1;
        gbc.gridwidth = 3;
        panel.add(component, gbc);
        gbc.gridwidth = 1;
    }

    private void uploadPhoto() {
        JFileChooser fileChooser = new JFileChooser();
        int result = fileChooser.showOpenDialog(null);
        if (result == JFileChooser.APPROVE_OPTION) {
            photoPath = fileChooser.getSelectedFile().getAbsolutePath();
            ImageIcon imageIcon = new ImageIcon(photoPath);
            Image image = imageIcon.getImage().getScaledInstance(lblPhoto.getWidth(), lblPhoto.getHeight(), Image.SCALE_SMOOTH);
            lblPhoto.setIcon(new ImageIcon(image));
        }
    }

    private boolean validateFields() {
        if (!tfApellido1.getText().matches("[a-zA-Z]+") || !tfApellido2.getText().matches("[a-zA-Z]+") ||
            !tfNombre1.getText().matches("[a-zA-Z]+") || !tfNombre2.getText().matches("[a-zA-Z]+")) {
            JOptionPane.showMessageDialog(null, "Los nombres y apellidos deben contener solo letras.");
            return false;
        }
        if (!tfEmail.getText().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            JOptionPane.showMessageDialog(null, "Correo electrónico no válido.");
            return false;
        }
        try {
            LocalDate.parse(tfFechaNacimiento.getText());
        } catch (DateTimeParseException e) {
            JOptionPane.showMessageDialog(null, "Fecha de nacimiento no válida.");
            return false;
        }
        try {
            new BigDecimal(tfSueldo.getText());
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(null, "Sueldo no válido.");
            return false;
        }
        return true;
    }

    private void addEmployee() {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "INSERT INTO empleados (EMPCODIGO, EMPAPELLIDO1, EMPAPELLIDO2, EMPNOMBRE1, EMPNOMBRE2, EMPFECHANACIMIENTO, EMPSEXO, EMPEMAIL, EMPDIRECCION, EMPTIPOSANGRE, EMPSUELDO, EMPBANCO, EMPCUENTA, EMPSTATUS, EMPFOTO) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'ACT', ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, tfCodigo.getText());
                stmt.setString(2, tfApellido1.getText());
                stmt.setString(3, tfApellido2.getText());
                stmt.setString(4, tfNombre1.getText());
                stmt.setString(5, tfNombre2.getText());
                stmt.setDate(6, Date.valueOf(tfFechaNacimiento.getText()));
                stmt.setString(7, cbSexo.getSelectedItem().toString());
                stmt.setString(8, tfEmail.getText());
                stmt.setString(9, tfDireccion.getText());
                stmt.setString(10, cbTipoSangre.getSelectedItem().toString());
                stmt.setBigDecimal(11, new BigDecimal(tfSueldo.getText()));
                stmt.setString(12, cbBanco.getSelectedItem().toString());
                stmt.setString(13, tfCuenta.getText());
                if (photoPath != null) {
                    stmt.setBytes(14, Files.readAllBytes(Paths.get(photoPath)));
                } else {
                    stmt.setBytes(14, null);
                }
                stmt.executeUpdate();
                JOptionPane.showMessageDialog(null, "Empleado agregado correctamente.");
                clearFields();
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    private void updateEmployee() {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "UPDATE empleados SET EMPAPELLIDO1 = ?, EMPAPELLIDO2 = ?, EMPNOMBRE1 = ?, EMPNOMBRE2 = ?, EMPFECHANACIMIENTO = ?, EMPSEXO = ?, EMPEMAIL = ?, EMPDIRECCION = ?, EMPTIPOSANGRE = ?, EMPSUELDO = ?, EMPBANCO = ?, EMPCUENTA = ?, EMPFOTO = ? WHERE EMPCODIGO = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, tfApellido1.getText());
                stmt.setString(2, tfApellido2.getText());
                stmt.setString(3, tfNombre1.getText());
                stmt.setString(4, tfNombre2.getText());
                stmt.setDate(5, Date.valueOf(tfFechaNacimiento.getText()));
                stmt.setString(6, cbSexo.getSelectedItem().toString());
                stmt.setString(7, tfEmail.getText());
                stmt.setString(8, tfDireccion.getText());
                stmt.setString(9, cbTipoSangre.getSelectedItem().toString());
                stmt.setBigDecimal(10, new BigDecimal(tfSueldo.getText()));
                stmt.setString(11, cbBanco.getSelectedItem().toString());
                stmt.setString(12, tfCuenta.getText());
                if (photoPath != null) {
                    stmt.setBytes(13, Files.readAllBytes(Paths.get(photoPath)));
                } else {
                    stmt.setBytes(13, null);
                }
                stmt.setString(14, tfCodigo.getText());
                stmt.executeUpdate();
                JOptionPane.showMessageDialog(null, "Empleado actualizado correctamente.");
                clearFields();
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    private void clearFields() {
        tfCodigo.setText("");
        tfApellido1.setText("");
        tfApellido2.setText("");
        tfNombre1.setText("");
        tfNombre2.setText("");
        tfFechaNacimiento.setText("");
        cbSexo.setSelectedIndex(0);
        tfEmail.setText("");
        tfDireccion.setText("");
        cbTipoSangre.setSelectedIndex(0);
        tfSueldo.setText("");
        cbBanco.setSelectedIndex(0);
        tfCuenta.setText("");
        lblPhoto.setIcon(null);
        photoPath = null;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(ScripJAVA_BD_Empleados::new);
    }
}

class EmployeeTable extends JFrame {
    private static final String URL = "jdbc:postgresql://localhost:5432/base";
    private static final String USER = "postgres";
    private static final String PASSWORD = "root234";
    private DefaultTableModel model;
    private JTable table;

    public EmployeeTable() {
        setTitle("Employee Table");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        model = new DefaultTableModel(new Object[]{"Codigo", "Apellido1", "Apellido2", "Nombre1", "Nombre2", "Fecha Nacimiento", "Sexo", "Email", "Direccion", "Tipo Sangre", "Sueldo", "Banco", "Cuenta", "Status", "Foto"}, 0);
        table = new JTable(model);
        table.setRowSorter(new TableRowSorter<>(model));
        JScrollPane scrollPane = new JScrollPane(table);

        JPanel panel = new JPanel(new BorderLayout());
        panel.add(scrollPane, BorderLayout.CENTER);

        JPanel bottomPanel = new JPanel();
        JButton refreshButton = new JButton("Actualizar");
        refreshButton.addActionListener(e -> loadEmployees());
        bottomPanel.add(refreshButton);

        JButton deleteButton = new JButton("Eliminar");
        deleteButton.addActionListener(e -> deleteEmployee());
        bottomPanel.add(deleteButton);

        JButton groupByButton = new JButton("Agrupar por");
        groupByButton.addActionListener(e -> groupBy());
        bottomPanel.add(groupByButton);

        panel.add(bottomPanel, BorderLayout.SOUTH);

        add(panel);
        loadEmployees();
        setVisible(true);
    }

    private void loadEmployees() {
        model.setRowCount(0);
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM empleados")) {
            while (rs.next()) {
                model.addRow(new Object[]{
                        rs.getString("EMPCODIGO"),
                        rs.getString("EMPAPELLIDO1"),
                        rs.getString("EMPAPELLIDO2"),
                        rs.getString("EMPNOMBRE1"),
                        rs.getString("EMPNOMBRE2"),
                        rs.getDate("EMPFECHANACIMIENTO"),
                        rs.getString("EMPSEXO"),
                        rs.getString("EMPEMAIL"),
                        rs.getString("EMPDIRECCION"),
                        rs.getString("EMPTIPOSANGRE"),
                        rs.getBigDecimal("EMPSUELDO"),
                        rs.getString("EMPBANCO"),
                        rs.getString("EMPCUENTA"),
                        rs.getString("EMPSTATUS"),
                        rs.getBytes("EMPFOTO")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteEmployee() {
    int selectedRow = table.getSelectedRow();
    if (selectedRow != -1) {
        int confirmation = JOptionPane.showConfirmDialog(null, "¿Estás seguro de cambiar el estado del empleado a inactivo?", "Confirmar", JOptionPane.OK_CANCEL_OPTION);
        if (confirmation == JOptionPane.OK_OPTION) {
            String codigo = model.getValueAt(selectedRow, 0).toString();
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                String sql = "UPDATE empleados SET EMPSTATUS = 'INA' WHERE EMPCODIGO = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, codigo);
                    stmt.executeUpdate();
                    model.setValueAt("INA", selectedRow, 13);  // Assuming EMPSTATUS is at column index 13
                    JOptionPane.showMessageDialog(null, "Empleado marcado como inactivo correctamente.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        JOptionPane.showMessageDialog(null, "Seleccione un empleado para marcar como inactivo.");
    }
}

    private void groupBy() {
        String[] columns = {"Codigo", "Apellido1", "Apellido2", "Nombre1", "Nombre2", "Fecha Nacimiento", "Sexo", "Email", "Direccion", "Tipo Sangre", "Sueldo", "Banco", "Cuenta", "Status"};
        String column = (String) JOptionPane.showInputDialog(null, "Seleccione la columna para agrupar:", "Agrupar por", JOptionPane.QUESTION_MESSAGE, null, columns, columns[0]);
        if (column != null) {
            TableRowSorter<DefaultTableModel> sorter = new TableRowSorter<>(model);
            sorter.setRowFilter(RowFilter.regexFilter("^.*$", model.findColumn(column)));
            table.setRowSorter(sorter);
        }
    }
}
