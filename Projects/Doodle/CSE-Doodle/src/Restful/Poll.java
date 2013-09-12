package REST;

/*
 * To change this template, choose Tools | Templates and open the template in
 * the editor.
 */
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import standard.*;

/**
 *
 * @author viennayy
 */
@Path("/Polls")
public class Poll {

    @POST
    // @Path("Create")
    @Produces("text/plain")
    @Consumes("application/json")
    public String Poll(JSONObject jo) { // Create a new Poll @FormParam(value = "name") String name,@FormParam(value = "name2") String name2
        //INSERT INTO Poll (Poll_ID, Poll_Title, Poll_Description, Poll_Initiator, Poll_Type, Poll_Lastmodify, Poll_Descsion, Poll_Status) 
        //VALUES ('1', '2', '3', '4', '5', 'a', 'b', 'c')
        //pollid,initiator,title,description,type,lastmodify,descsion,oType,oContent,oSubCon,emailto,status
        String re = "";
        PollBean CurrentPoll = new PollBean();
        ArrayList<OptionBean> ops = new ArrayList<OptionBean>();
        DataBaseOp dbop = new DataBaseOp();
        SendEmail se = new SendEmail();
        try {
            // JSONArray arr = jn.getJSONArray("arr");      // if data in json is a atring array
            // re = "i am a poll " + jo.toString();//+"---"+arr.getString(0);
            //CurrentPoll.setPoll_ID(jo.getString("pollid"));
            CurrentPoll.setPoll_Title(jo.getString("title"));
            CurrentPoll.setPoll_Description(jo.getString("description"));
            CurrentPoll.setPoll_Type(jo.getString("type"));
            CurrentPoll.setPoll_Initiator(jo.getString("initiator"));
            CurrentPoll.setPoll_Lastmodify(jo.getString("lastmodify"));
            CurrentPoll.setPoll_Descsion(jo.getString("descsion"));
            CurrentPoll.setPoll_Status("1");

            CurrentPoll.setPoll_ID(dbop.InsertPoll(CurrentPoll));
            if (!"".equals(CurrentPoll.getPoll_ID())) {
                // DateTime
                if (Integer.parseInt(CurrentPoll.getPoll_Type()) == 1) {
                    String[] DateTime = jo.getString("oSubCon").split(";");
                    for (int i = 0; i < DateTime.length; i++) {
                        String[] dt = DateTime[i].split(" ");
                        OptionBean op = new OptionBean();
                        op.setpID(CurrentPoll.getPoll_ID());
                        op.setpType(CurrentPoll.getPoll_Type());
                        op.setoContent(dt[0]);
                        op.setSubCon(dt[1]);

                        ops.add(op);
                    }
                } else if (Integer.parseInt(CurrentPoll.getPoll_Type()) == 2) {//Text
                    String[] Loc = jo.getString("oSubCon").split(";");
                    for (int i = 0; i < Loc.length; i++) {

                        OptionBean op = new OptionBean();
                        op.setpID(CurrentPoll.getPoll_ID());
                        op.setpType(CurrentPoll.getPoll_Type());
                        op.setoContent(Integer.toString(i));
                        op.setSubCon(Loc[i]);

                        ops.add(op);
                    }
                }

                if (dbop.InsertPollOptions(ops) == 1) {
                    re = CurrentPoll.getPoll_ID();
                    // send email

                    String[] email = jo.getString("emailto").split(";");
                    for (int i = 0; i < email.length; i++) {
                        se.sendMail("Meeting Notice", "to participate  http://localhost:8080/CSE-Doodle-Client/Polls/" + re, email[i]);
                    }
                }
            }


        } catch (Exception ex) {
        }

        dbop.ReleaseO();
        return re;
    }

    @GET
    @Path("/{Pollid}")
    @Produces("application/json")
    public String getPoll(@PathParam("Pollid") String Pollid) {
        //http://localhost:8081/CSE-Doodle/REST/Polls/123
        //search poll
        DataBaseOp dbop = new DataBaseOp();
        if ("MyPolls".equals(Pollid.trim())) {
            ArrayList<PollBean> pbs = null;
            pbs = dbop.SelMyVotes(Pollid);
            Gson gson = new Gson();
            String json = gson.toJson(pbs);
            //return object
            dbop.ReleaseO();
            return json;
        }

        PollBean CurrentPoll = null;

        CurrentPoll = dbop.SelAPoll(Pollid);

        //search content
        ArrayList<OptionBean> ops = null;
        ops = dbop.SelOptions(Pollid);

        //search rate
        ArrayList<Vote> vts = null;
        vts = dbop.SelVotes(Pollid);

        //search comment
        ArrayList<Comment> comms = null;
        comms = dbop.SelComments(Pollid);

        Jobj reObj = new Jobj(CurrentPoll, ops, vts, comms);
        //String json = "{name=\"json\",bool:true,int:1,double:2.2,func:function(a){ return a; },array:[1,2]}";
//JSONObject jsonObject = JSONObject.fromString(json); 
        Gson gson = new Gson();
        String json = gson.toJson(reObj);

        //return object
        dbop.ReleaseO();
        return json;
    }

    @PUT
    @Path("/{Pollid}")
    @Produces("text/plain")
    @Consumes("application/json")
    public String UpdatePoll(JSONObject jo, @PathParam("Pollid") String Pollid) {
        String re1 = "";
        DataBaseOp dbop = new DataBaseOp();
        Vote vt = new Vote();
        Comment comm = new Comment();
        try {
            //re = jo.toString() + "---" + Pollid;

            vt.setVote_Creator(jo.getString("uid").trim());
            vt.setVote_Option(jo.getString("oid").trim());
            vt.setVote_Poll(jo.getString("pid").trim());
            if (!"".equals(vt.getVote_Option().trim())) {
                re1 = Integer.toString(dbop.InsertVote(vt));
            }

            comm.setComment_Poll(jo.getString("pid").trim());
            comm.setComment_Creator(jo.getString("c_uid").trim());
            comm.setComment_Content(jo.getString("cont").trim());
            comm.setComment_DateTime(jo.getString("time").trim());
            if (!"".equals(comm.getComment_Content().trim())) {
                re1 = Integer.toString(dbop.InsertComm(comm));
            }
        } catch (Exception ex) {
        }
        dbop.ReleaseO();
        return re1;
    }

    @DELETE
    @Path("/Comment")
    @Produces("text/plain")
    @Consumes("application/json")
    public String DeleteComm(JSONObject jo) {
        String re1 = "aa";
        DataBaseOp dbop = new DataBaseOp();

        try {
            //re = jo.toString() + "---" + Pollid;

            re1 = Integer.toString(dbop.DeleteComm(jo.getString("comm_id")));

        } catch (Exception ex) {
        }
        dbop.ReleaseO();
        return re1;
    }

    @PUT
    @Path("/Comment")
    @Produces("text/plain")
    @Consumes("application/json")
    public String UpdateComm(JSONObject jo) {
        String re1 = "aa";
        DataBaseOp dbop = new DataBaseOp();
        Comment comm = new Comment();
        try {
            //re = jo.toString() + "---" + Pollid;
            comm.setComment_ID(jo.getString("comm_id").trim());
            comm.setComment_Poll(jo.getString("pid").trim());
            comm.setComment_Creator(jo.getString("c_uid").trim());
            comm.setComment_Content(jo.getString("cont").trim());
            comm.setComment_DateTime(jo.getString("time").trim());
            re1 = Integer.toString(dbop.UpdateComm(comm));

        } catch (Exception ex) {
        }
        dbop.ReleaseO();
        return re1;
    }

    @DELETE
    @Path("/Vote")
    @Produces("text/plain")
    @Consumes("application/json")
    public String DeleteVote(JSONObject jo) {
        String re1 = "";
        DataBaseOp dbop = new DataBaseOp();

        try {
            //re = jo.toString() + "---" + Pollid;

            re1 = Integer.toString(dbop.DeleteVote(jo.getString("vote_id").trim()));

        } catch (Exception ex) {
        }
        dbop.ReleaseO();
        return re1;
    }

    @PUT
    @Path("/Vote")
    @Produces("text/plain")
    @Consumes("application/json")
    public String UpdateVote(JSONObject jo) {
        String re1 = "";
        DataBaseOp dbop = new DataBaseOp();
        Vote vt = new Vote();
        try {
            //re = jo.toString() + "---" + Pollid;
            vt.setVote_ID(jo.getString("vote_id").trim());
            vt.setVote_Creator(jo.getString("uid").trim());
            vt.setVote_Option(jo.getString("oid").trim());
            vt.setVote_Poll(jo.getString("pid").trim());
            re1 = Integer.toString(dbop.UpdateVote(vt));

        } catch (Exception ex) {
        }
        dbop.ReleaseO();
        return re1;
    }

    @GET
    @Path("/MyPolls/{uid}")
    @Produces("application/json")
    public String getmyPolls(@PathParam("uid") String uid) {
        //http://localhost:8081/CSE-Doodle/REST/Polls/123
        //search poll
        DataBaseOp dbop = new DataBaseOp();

        ArrayList<PollBean> pbs = null;
        pbs = dbop.SelMyPolls(uid);
        Gson gson = new Gson();
        String json = gson.toJson(pbs);
        //return object
        dbop.ReleaseO();
        return json;

    }

    @DELETE
    @Path("/Poll")
    @Produces("text/plain")
    @Consumes("application/json")
    public String DeletePoll(JSONObject jo) {
        String re1 = "deletepoll";
        DataBaseOp dbop = new DataBaseOp();

        try {
            //re = jo.toString() + "---" + Pollid;
            re1 = Integer.toString(dbop.DeletePoll(jo.getString("pollid")));
        } catch (Exception ex) {
        }
        dbop.ReleaseO();
        return re1;
    }

    @PUT
    @Path("Poll")
    @Produces("text/plain")
    @Consumes("application/json")
    public String UpdatePoll(JSONObject jo) { // Create a new Poll @FormParam(value = "name") String name,@FormParam(value = "name2") String name2
        //INSERT INTO Poll (Poll_ID, Poll_Title, Poll_Description, Poll_Initiator, Poll_Type, Poll_Lastmodify, Poll_Descsion, Poll_Status) 
        //VALUES ('1', '2', '3', '4', '5', 'a', 'b', 'c')
        //pollid,initiator,title,description,type,lastmodify,descsion,oType,oContent,oSubCon,emailto,status
        String re = "";
        PollBean CurrentPoll = new PollBean();
        ArrayList<OptionBean> ops = new ArrayList<OptionBean>();
        DataBaseOp dbop = new DataBaseOp();
         SendEmail se = new SendEmail();
        try {
            // JSONArray arr = jn.getJSONArray("arr");      // if data in json is a atring array
            // re = "i am a poll " + jo.toString();//+"---"+arr.getString(0);



            CurrentPoll.setPoll_ID(jo.getString("pollid"));
            CurrentPoll.setPoll_Title(jo.getString("title"));
            CurrentPoll.setPoll_Description(jo.getString("description"));
            CurrentPoll.setPoll_Type(jo.getString("type"));
            CurrentPoll.setPoll_Initiator(jo.getString("initiator"));
            CurrentPoll.setPoll_Lastmodify(jo.getString("lastmodify"));
            CurrentPoll.setPoll_Descsion(jo.getString("descsion"));
            CurrentPoll.setPoll_Status(jo.getString("status"));
            if ("3".equals(jo.getString("status"))) {
                re = dbop.ClosePoll(CurrentPoll);
                dbop.ReleaseO();
                return re;
            }
            //   update poll
            dbop.UpdatePoll(CurrentPoll);
            dbop.Deleteoption(CurrentPoll.getPoll_ID());
            if (!"".equals(CurrentPoll.getPoll_ID())) {
                // DateTime
                if (Integer.parseInt(CurrentPoll.getPoll_Type()) == 1) {
                    String[] DateTime = jo.getString("oSubCon").split(";");
                    for (int i = 0; i < DateTime.length; i++) {
                        String[] dt = DateTime[i].split(" ");
                        OptionBean op = new OptionBean();
                        op.setpID(CurrentPoll.getPoll_ID());
                        op.setpType(CurrentPoll.getPoll_Type());
                        op.setoContent(dt[0]);
                        op.setSubCon(dt[1]);

                        ops.add(op);
                    }
                } else if (Integer.parseInt(CurrentPoll.getPoll_Type()) == 2) {//Text
                    String[] Loc = jo.getString("oSubCon").split(";");
                    for (int i = 0; i < Loc.length; i++) {

                        OptionBean op = new OptionBean();
                        op.setpID(CurrentPoll.getPoll_ID());
                        op.setpType(CurrentPoll.getPoll_Type());
                        op.setoContent(Integer.toString(i));
                        op.setSubCon(Loc[i]);

                        ops.add(op);
                    }
                }

                if (dbop.InsertPollOptions(ops) == 1) {
                    re = CurrentPoll.getPoll_ID();
                    // send email
                    String[] email = jo.getString("emailto").split(";");
                    for (int i = 0; i < email.length; i++) {
                        se.sendMail("Meeting Notice", "to participate  http://localhost:8080/CSE-Doodle-Client/Polls/" + re, email[i]);
                    }
                    
                }
            }


        } catch (Exception ex) {
        }

        dbop.ReleaseO();
        return re;
    }
}
