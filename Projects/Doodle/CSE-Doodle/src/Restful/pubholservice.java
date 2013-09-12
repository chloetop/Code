/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package REST;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import standard.XmlOp;

/**
 *
 * @author Administrator
 */
@Path("/pubholservice")
public class pubholservice {

    @GET
    @Path("/{state}/{date}")
    @Produces("text/plain")
    public String HolidayCheck(@PathParam("state") String state, @PathParam("date") String date) {
        String re = "" + state + date;
        String mess = "";
        XmlOp xmlop = new XmlOp();
        re = xmlop.GetXml(state, date, 3);
      
        if (re.indexOf("<name>") > 0) {
            mess = re.substring(re.indexOf("<name>") + 6, re.indexOf("</name>"));
        }
        if("".equals(mess))
            mess = "It is not a public holiday";
        return mess;
    }

    @GET
    @Path("/{state}/show")
    @Produces(MediaType.TEXT_XML)
    public String Holidayhtml(@PathParam("state") String state) {
        String re = "<html> " + "<title>" + "Hello Jersey" + "</title>" + "<body><h1>" + state + "</h1></body>" + "</html> ";
        XmlOp xmlop = new XmlOp();
        re = xmlop.GetXml(state, "", 2);

        return re;
    }

    @GET
    @Path("/{state}")
    @Produces(MediaType.TEXT_XML)
    public String HolidayXMM(@PathParam("state") String state) {
        String re = "<?xml version=\"1.0\"?><state>" + state + "</state>";
        XmlOp xmlop = new XmlOp();
        // re = xmlop.ReadFile();
        re = xmlop.GetXml(state, "", 1);
        return re;
    }
}
