/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.io.File;

public class Xml_Operation {

    File XmlFile = null;
    DocumentBuilderFactory dbFactry = null;
    DocumentBuilder dBuilder = null;
    Document doc = null;

    private boolean Xml_Init(String FileName) {
        try {
            XmlFile = new File(this.getClass().getResource("/").getPath());
            XmlFile = new File(XmlFile.getParent());
            XmlFile = new File(XmlFile.getParent() + "/"+FileName);
            //   System.out.println(str);
            dbFactry = DocumentBuilderFactory.newInstance();
            dBuilder = dbFactry.newDocumentBuilder();
            doc = dBuilder.parse(XmlFile);
            doc.getDocumentElement().normalize();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public NodeList ReadXml(String FileName,String sTag) {
        if (!Xml_Init(FileName)) {
            return null;
        } else {
            NodeList nList = doc.getElementsByTagName(sTag);
            return nList;
        }
    }
;
}
