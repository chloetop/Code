/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package PublicClass;

import java.sql.*;

/**
 *
 * @author Administrator
 */
public class DataBase {

    private String url;
    private String sa;
    private String pwd;
    private String className;
    private Connection Conn = null;
    private Statement Stmt = null;
    private ResultSet rs = null;

    /**
     * @return the url
     */
    public String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return the sa
     */
    public String getSa() {
        return sa;
    }

    /**
     * @param sa the sa to set
     */
    public void setSa(String sa) {
        this.sa = sa;
    }

    /**
     * @return the pwd
     */
    public String getPwd() {
        return pwd;
    }

    /**
     * @param pwd the pwd to set
     */
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    /**
     * @return the className
     */
    public String getClassName() {
        return className;
    }

    /**
     * @param className the className to set
     */
    public void setClassName(String className) {
        this.className = className;
    }

    private void Init() {
//        url = "jdbc:oracle:thin:@localhost:1521:GROUP15";
//        sa = "SYSTEM";
//        pwd = "sa";
//        className = "oracle.jdbc.driver.OracleDriver";
            url = "jdbc:hsqldb:hsql://localhost:9001/hoteldb";
        sa = "sa";
        pwd = "";
        className = "org.hsqldb.jdbcDriver";
        this.setUrl(url);
        this.setSa(sa);
        this.setPwd(pwd);
        this.setClassName(className);
    }

    public ResultSet ExecuteSQL(String strSQL) {
        try {
            Init();
            Class.forName(this.getClassName());
            Conn = DriverManager.getConnection(this.getUrl(), this.getSa(), this.getPwd());
            Stmt = Conn.createStatement();
            rs = Stmt.executeQuery(strSQL);
//        int row = rs.getRow();
//        while(rs.next())
//            System.out.println(rs.getString("col2"));


        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rs;
    }

    public int ExecuteSQL2(String strSQL) {
        int tag = 0;
        try {
            Init();
            Class.forName(this.getClassName());
            Conn = DriverManager.getConnection(this.getUrl(), this.getSa(), this.getPwd());
            Stmt = Conn.createStatement();
            tag = Stmt.executeUpdate(strSQL);
//        int row = rs.getRow();
//        while(rs.next())
//            System.out.println(rs.getString("col2"));


        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return tag;
    }

    public void SQLRelase() {
        try {
            this.rs.close();
            this.Stmt.close();
            this.Conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
