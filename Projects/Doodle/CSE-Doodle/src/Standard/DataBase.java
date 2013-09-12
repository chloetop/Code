package standard;

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

    public DataBase() {
//        url = "jdbc:oracle:thin:@localhost:1521:GROUP15";
//        sa = "SYSTEM";
//        pwd = "sa";
//        className = "oracle.jdbc.driver.OracleDriver";
        url = "jdbc:sqlite:../ass2.db";
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

            rs = Stmt.executeQuery(strSQL);

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rs;
    }
    // update, insert, delete SQL

    public int ExecuteSQL2(String strSQL) {
        int tag = 0;
        try {

            tag = Stmt.executeUpdate(strSQL);

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
            tag = 0;
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

    public String GenerateID(String TableName) {
        String id = "";
        String sql = "";
        if ("Comment".equals(TableName)) {
            sql = "select count(*) as num, max(Comment_ID) as largest from Comment";
        }
        if ("Poll".equals(TableName)) {
            sql = "select count(*) as num, max(Poll_ID) as largest from Poll";
        }
        if ("PollOption".equals(TableName)) {
            sql = "select count(*) as num, max(Option_ID) as largest from PollOption";
        }
        if ("Vote".equals(TableName)) {
            sql = "select count(*) as num, max(Vote_ID) as largest from Vote";
        }
       
        ResultSet rs = this.ExecuteSQL(sql);

        try {
            int No = Integer.parseInt(rs.getString("num"));
            if (No == 0) {
                id = "000001";
            } else {
                id = String.format("%06d", Integer.parseInt(rs.getString("largest")) + 1);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return id;
    }
}
