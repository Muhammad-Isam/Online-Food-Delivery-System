/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dbms.eat;
import Class.Restaurant;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ConnectionToDB {
    
    public Connection establishConnection()
    {
        Connection connection=null;
        String url = "jdbc:sqlserver://localhost:1433;databaseName=FoodDelivery;ecrypt=true;trustServerCertificate=true;";
//        String storedProcedureCall = "{call dbo.display(?)}";
      String username = "sa";
        String password = "1234";
        try {
            connection = DriverManager.getConnection(url,username,password);
            System.out.println("Connected to the database successfully!");
  
//            try (CallableStatement callableStatement = connection.prepareCall(storedProcedureCall)) {
//                callableStatement.setInt(1, 3);
//                callableStatement.execute();
//                System.out.println("Stored procedure executed successfully!");
//               ResultSet rs = callableStatement.getResultSet();
//                while (rs.next()) {
//                            int stdID = rs.getInt("StdID");
//                            String stdName = rs.getString("StdName");
//                            // Add more fields as needed
//
//                            System.out.println("StdID: " + stdID + ", StdName: " + stdName);
//                            // Print or process other fields
//                        }
//            }
        } 
        catch (SQLException e) {
            System.err.println("Connection failed. Error message: " + e.getMessage());
        }
                    return connection;

    }
}
    
