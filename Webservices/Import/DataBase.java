package au.edu.unsw.sltf.services;

/*
 * To change this template, choose Tools | Templates and open the template in
 * the editor.
 */
import java.sql.*;
import java.util.List;
import java.util.Random;

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
    private String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    private void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return the sa
     */
    private String getSa() {
        return sa;
    }

    /**
     * @param sa the sa to set
     */
    private void setSa(String sa) {
        this.sa = sa;
    }

    /**
     * @return the pwd
     */
    private String getPwd() {
        return pwd;
    }

    /**
     * @param pwd the pwd to set
     */
    private void setPwd(String pwd) {
        this.pwd = pwd;
    }

    /**
     * @return the className
     */
    private String getClassName() {
        return className;
    }

    /**
     * @param className the className to set
     */
    private void setClassName(String className) {
        this.className = className;
    }

    public void Init() {
//        url = "jdbc:oracle:thin:@localhost:1521:GROUP15";
//        sa = "SYSTEM";
//        pwd = "sa";
//        className = "oracle.jdbc.driver.OracleDriver";
        url = "jdbc:sqlite:/Users/viennayy/JavaProjects/tet.db";
        ///Users/viennayy/9322/cs9322_package/apache-tomcat-6.0.20/bin/tet.db
        sa = "sa";
        pwd = "";
        className = "org.sqlite.JDBC";
        this.setUrl(url);
        this.setSa(sa);
        this.setPwd(pwd);
        this.setClassName(className);
        try {
            Class.forName(this.getClassName());
            this.Conn = DriverManager.getConnection(this.getUrl());
            this.Stmt = this.Conn.createStatement();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }
    // Select SQL

    public ResultSet ExecuteSQL(String strSQL) {
        try {
                       // Stmt.execute("begin");
            rs = Stmt.executeQuery(strSQL);
            //  Stmt.execute("end");
//        int row = rs.getRow();
//        while(rs.next())
//            System.out.println(rs.getString("col2"));


        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rs;
    }
    // update, insert, delete SQL

    public int ExecuteSQL2(String strSQL) {
        int tag = 0;
        try {
           
            // Stmt.execute("begin");
            tag = Stmt.executeUpdate(strSQL);
            // Stmt.execute("end");
//        int row = rs.getRow();
//        while(rs.next())
//            System.out.println(rs.getString("col2"));


        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return tag;
    }

    public int ExecuteSQL2(List strSQL) {
        int tag = 0;
        int i = 0;
        try {
                      // Stmt.execute("begin");
            for (i = 0; i < strSQL.size(); i++) {
                Stmt.executeUpdate(strSQL.get(i).toString());
            }
            // Stmt.execute("end");

            tag = 1;
        } catch (Exception ex) {
            ex.printStackTrace();
            tag = 2;
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

    public String GenerateID() {
        String id = "";
        Random random = new Random();
        String PIN = "";
        int tag1 = 0;
        int tag2 = 0;
        try {
            while (true) {
                int x = random.nextInt(999999);
                if (x > 99999) {
                    ResultSet temp = ExecuteSQL("SELECT * FROM stock WHERE eventid ='" + x + "'");
                    while (temp.next()) {
                    }
                    if (temp.getRow() == 0) {

                        tag1 = 1;
                        // break;
                    }
                    temp = ExecuteSQL("SELECT * FROM merge WHERE eventsetid ='" + x + "'");
                    while (temp.next()) {
                    }
                    if (temp.getRow() == 0) {

                        tag2 = 1;
                        // break;
                    }
                    if (tag1 == 1 && tag2 == 1) {
                        id = Integer.toString(x);
                        break;
                    }

                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return id;
    }

    public ResultSet ExecuteEventidFromStock(String eventid) {
        ResultSet temp = null;

        temp = ExecuteSQL("SELECT * FROM stock WHERE eventid ='" + eventid + "' order by date");

        return temp;
        // break;
    }

    public ResultSet ExecuteEventidFromMerge(String eventid) {
        ResultSet temp = null;

        temp = ExecuteSQL("SELECT * FROM merge WHERE eventsetid ='" + eventid + "'");

        return temp;
        // break;
    }
}
