/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package au.edu.unsw.sltf.services;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * @author viennayy
 */
public class CsvReader {

    private URL url = null;
    private URLConnection urlConn = null;
    private InputStream inputstream = null;
    private InputStreamReader inStream = null;
    private BufferedReader buff = null;
    private String csvString;
    private List list = null;

    public List readcsv(String link, String eventid, String sec, Date DS, Date DE) {
        try {
            //url = new URL("http://ichart.finance.yahoo.com/table.csv?s=GOOG&a=07&b=20&c=2012&d=07&e=26&f=2012&g=d&ignore=.csv");
            url = new URL(link);
            urlConn = url.openConnection();
            inputstream = urlConn.getInputStream();
            inStream = new InputStreamReader(inputstream);
            buff = new BufferedReader(inStream);
            list = new ArrayList();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date d1 = DS;
            Date d2 = DE;
            Date dt;
            while ((csvString = buff.readLine()) != null) {
                //show.println(csvString + "</br>");
                StringTokenizer tokenizer = new StringTokenizer(csvString, ",");
                String date = tokenizer.nextToken();
                if ("date".equals(date.toLowerCase())) {
                    continue;
                }
                dt = df.parse(date);
                if (dt.getTime() < d1.getTime() || dt.getTime() > d2.getTime()) {
                    continue;
                }
                String open = tokenizer.nextToken();
                String high = tokenizer.nextToken();
                String low = tokenizer.nextToken();
                String close = tokenizer.nextToken();
                String volume = tokenizer.nextToken();
                String adjclose = tokenizer.nextToken();
                list.add("insert into stock values('" + sec + "','" + date + "','" + open + "','" + high + "','" + low + "','" + close + "','" + volume + "','" + adjclose + "','" + eventid + "')");
            }

        } catch (Exception ex) {
            list.clear();
        }

        return list;
    }

    public String RStoCSV(ResultSet rs, String eventid) {
        File f = null;
        BufferedWriter csvWriter = null;
        FileOutputStream fout = null;
        Random random = null;
        String fn = "";

        try {
            //int ss = (new Random()).nextInt() & 0xffff;
           // f = new File("../webapps/ROOT/Sotck" + eventid + ".csv");
        	 f = new File("/Users/viennayy/9322/lab3/apache-tomcat-6.0.20-p14080/webapps/ROOT/Sotck" + eventid + ".csv");
        	fn = "Sotck" + eventid + ".csv";
            fout = new FileOutputStream(f);
            csvWriter = new BufferedWriter(new OutputStreamWriter(fout));
            csvWriter.write("Sec");
            csvWriter.write(",");
            csvWriter.write("Date");
            csvWriter.write(",");
            csvWriter.write("Open");
            csvWriter.write(",");
            csvWriter.write("High");
            csvWriter.write(",");
            csvWriter.write("Low");
            csvWriter.write(",");
            csvWriter.write("Close");
            csvWriter.write(",");
            csvWriter.write("Volume");
            csvWriter.write(",");
            csvWriter.write("Adj Close");
            csvWriter.newLine();
            while (rs.next()) {
                csvWriter.write(rs.getString("sec"));
                csvWriter.write(",");
                csvWriter.write(rs.getString("date"));
                csvWriter.write(",");
                csvWriter.write(rs.getString("open"));
                csvWriter.write(",");
                csvWriter.write(rs.getString("high"));
                csvWriter.write(",");
                csvWriter.write(rs.getString("low"));
                csvWriter.write(",");
                csvWriter.write(rs.getString("close"));
                csvWriter.write(",");
                csvWriter.write(rs.getString("volume"));
                csvWriter.write(",");
                csvWriter.write(rs.getString("adjclose"));
                csvWriter.newLine();
            }



            csvWriter.flush();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return fn;
    }
}
