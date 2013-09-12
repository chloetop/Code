/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package standard;

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

import java.io.IOException;
//import java.util.Iterator;
//import java.util.List;
import java.util.Properties;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.*;
import org.xml.sax.SAXException;

import net.sf.saxon.dom.*;
//import net.sf.saxon.om.NodeInfo;
import net.sf.saxon.query.*;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.*;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import net.sf.saxon.Configuration;
import net.sf.saxon.query.DynamicQueryContext;
import net.sf.saxon.query.StaticQueryContext;
import net.sf.saxon.query.XQueryExpression;
import net.sf.saxon.trans.XPathException;

/**
 *
 * @author Administrator
 */
public class XmlOp {

    public String XqueryToXML() {
        String re = "";

        String query = "<ul>\n"
                + "{\n"
                + "for $b in //bib/book\n"
                + "where $b/publisher = \"Addison-Wesley\" and $b/@year > 1992 "
                + "return\n" + "<li>{ data($b/title) }</li>\n" + "}\n"
                + "</ul>";

        Document doc = input("../test.xml");
        Document doc2 = input("../result.xml");
        Configuration c = new Configuration();

        StaticQueryContext qp = new StaticQueryContext(c);
        XQueryExpression xe;
        String str = "";
        TransformerFactory tFactory = TransformerFactory.newInstance();
        Transformer transformer;
        try {
            xe = qp.compileQuery(query);
            DynamicQueryContext dqc = new DynamicQueryContext(c);
            dqc.setContextNode(new DocumentWrapper(doc, null, c));

            final Properties props = new Properties();
            props.setProperty(OutputKeys.METHOD, "xml");
            props.setProperty(OutputKeys.INDENT, "yes");
            StreamResult aa = new StreamResult(System.out);
            xe.run(dqc, aa, props); //new StreamResult(System.out)
            transformer = tFactory.newTransformer();
            DOMSource source = new DOMSource(doc2);
            transformer.transform(source, aa);

            str = aa.getWriter().toString();

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }



        return re;
    }

    public String XsltToXML() {
        String re = "";
        return re;
    }

    public static Document input(String filename) {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;

        Document doc = null;
        try {
            builder = factory.newDocumentBuilder();
            doc = builder.parse(filename);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        doc.normalize();
        return doc;
    }

    public static void output(Document _doc) {
        TransformerFactory tFactory = TransformerFactory.newInstance();
        Transformer transformer;
        try {
            transformer = tFactory.newTransformer();
            Properties properties = transformer.getOutputProperties();
            properties.setProperty(OutputKeys.INDENT, "yes");
            properties.setProperty(OutputKeys.ENCODING, "GB2312");
            properties.setProperty(OutputKeys.METHOD, "xml");
            properties.setProperty(OutputKeys.VERSION, "1.0");
            transformer.setOutputProperties(properties);
            DOMSource source = new DOMSource(_doc);
            StreamResult result = new StreamResult(System.out);
            transformer.transform(source, result);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public String ReadFile() {
        String re = "";
        URL url = null;
        URLConnection urlConn = null;
        InputStream inputstream = null;
        InputStreamReader inStream = null;
        BufferedReader buff = null;
        String csvString;
        List list = null;

        try {
            url = new URL("http://localhost:8080/test.xml");
            urlConn = url.openConnection();
            inputstream = urlConn.getInputStream();
            inStream = new InputStreamReader(inputstream);
            buff = new BufferedReader(inStream);
            list = new ArrayList();

            while ((csvString = buff.readLine()) != null) {
                //show.println(csvString + "</br>");
                re += csvString;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return re;

    }

    public String GetXml(String state1, String date1, int op) {
        String re = "";
        String state = state1;
        final Configuration config = new Configuration();
        final StaticQueryContext sqc = new StaticQueryContext(config);
        final XQueryExpression exp;
        String strData = "";
        if (op == 3 && !"".equals(date1)) {
            strData = " and $x/day = \""+date1+"\"";
        }
        try {
            String query = "for $x in doc(\"http://localhost:8080/holidays.xml\")/holidays/holiday\n"
                    + " where $x/state = \"" + state + "\" " + strData + " \n"
                    + " return $x";
            exp = sqc.compileQuery(query);
            final DynamicQueryContext dynamicContext = new DynamicQueryContext(config);
            dynamicContext.setContextItem(config.buildDocument(new StreamSource("http://localhost:8080/holidays.xml")));
            final Properties props = new Properties();
            props.setProperty(OutputKeys.METHOD, "xml");
            //     props.setProperty(OutputKeys.DOCTYPE_PUBLIC, "<?xml-stylesheet type=\"text/xsl\" href=\"show.xsl\"?>");
            StringBuffer bs = null;
            Writer writer = new StringWriter();
            String str = "";
            if (op == 1) {
            } else if (op == 2 ) {
                str = "\n<?xml-stylesheet type=\"text/xsl\" href=\"http://localhost:8080/show.xsl\"?>\n";
            }
            str += "<holidays xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"http://localhost:8080/pubholservice/xml/holidays.xsd\">\n";
            //writer.write(str);

            exp.run(dynamicContext, new StreamResult(writer), props);
            StringBuffer sb = new StringBuffer();
            sb.append(writer.toString());
            sb.insert(38, str);
            sb.append("\n</holidays>");
            //    System.out.println(sb.toString());
            re = sb.toString();
        } catch (Exception ex) {
        }
        return re;
    }
}
