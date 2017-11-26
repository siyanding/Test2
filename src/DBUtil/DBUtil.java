package DBUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBUtil {

    private static final DBUtil db = new DBUtil();

    private DBUtil() {
        connect();
    }

    public static DBUtil getDB() {
        return db;
    }


    public static Connection connect() {
        Connection conn = null;

        try {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            conn =
                    DriverManager.getConnection("jdbc:mysql://localhost:3306/gift","root", "123456");

            // Do something with the Connection


        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return conn;

    }

    public static void closeConnection(Connection conn){
        // 判断conn是否为空
        if(conn != null){
            try {
                conn.close();	// 关闭数据库连接
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    //add a new img in gift
    public void AddGift(String username,String background, String comment,String coordinate){
        // 获取数据库连接Connection对象
        Connection conn = connect();
        // 插入用户注册信息的SQL语句
        String sql = "insert into gifts(background,user,comment,coordinate) values(?,?,?,?)";
        try {
            // 获取PreparedStatement对象
            PreparedStatement ps = conn.prepareStatement(sql);
            // 对SQL语句的占位符参数进行动态赋值
            ps.setString(1,background);
            ps.setString(2,username);
            ps.setString(3,comment);
            ps.setString(4,coordinate);

            // 执行更新操作
            ps.executeUpdate();
            // 释放此 PreparedStatement 对象的数据库和 JDBC 资源
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            // 关闭数据库连接
            closeConnection(conn);
        }
    }
}
