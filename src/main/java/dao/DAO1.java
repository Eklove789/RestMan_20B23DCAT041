package dao;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Lop DAO truu tuong: khoi tao ket noi CSDL mot lan, moi lop DAO ke thua de dung chung.
 * Sua dbUrl, dbUser, dbPassword cho phu hop voi MySQL tren may minh.
 */
public abstract class DAO1 {
    protected static Connection con;

    private static final String dbClass = "com.mysql.cj.jdbc.Driver";
    private static final String dbUrl = "jdbc:mysql://localhost:3307/restman1"
            + "?useUnicode=true&characterEncoding=UTF-8&useSSL=false"
            + "&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh";
    private static final String dbUser = "root";
    private static final String dbPassword = "123456";

    public DAO1() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
