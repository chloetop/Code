/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package REST;

import com.google.gson.Gson;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.ws.rs.*;
import standard.*;

/**
 *
 * @author Administrator
 */
@Path("/MyVotes")
public class myvotes {

    @GET
    @Path("{Pollid}")
    @Produces("application/json")
    public String getPoll(@PathParam("Pollid") String Pollid) {
        //http://localhost:8081/CSE-Doodle/REST/Polls/123
        //search poll
      
        DataBaseOp dbop = new DataBaseOp();

        ArrayList<PollBean> pbs = null;
        pbs = dbop.SelMyVotes(Pollid);


        Gson gson = new Gson();
        String json = gson.toJson(pbs);

        //return object
        dbop.ReleaseO();
        return json;
    }
}
