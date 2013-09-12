/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package standard;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class DataBaseOp {

    private DataBase db = new DataBase();

    public String InsertPoll(PollBean pb) {
        //INSERT INTO Poll (Poll_ID, Poll_Title, Poll_Description, Poll_Initiator, Poll_Type, Poll_Lastmodify, Poll_Descsion, Poll_Status) 
        //VALUES ('1', '2', '3', '4', '5', 'a', 'b', 'c')
        String re = ""; // correct
        int tag = -1;

        pb.setPoll_ID(db.GenerateID("Poll"));
        String sql = "INSERT INTO Poll (Poll_ID, Poll_Title, Poll_Description, Poll_Initiator, Poll_Type, Poll_Lastmodify, Poll_Descsion, Poll_Status) VALUES ";
        sql += "('" + pb.getPoll_ID() + "', '" + pb.getPoll_Title() + "', '" + pb.getPoll_Description() + "', '" + pb.getPoll_Initiator() + "', '" + pb.getPoll_Type() + "', '" + pb.getPoll_Lastmodify() + "', '" + pb.getPoll_Descsion() + "', '" + pb.getPoll_Status() + "')";

        tag = db.ExecuteSQL2(sql);
        if (tag != 0) {
            re = pb.getPoll_ID();
        }
        return re;
    }

    public int InsertPollOptions(ArrayList<OptionBean> ops) {
        int re = -1;
        //INSERT INTO PollOption (Option_ID, Option_Poll, Option_Poll_Type, Option_Content, Option_SubCon) 
        //VALUES ('1', '2', '3', '4', '5')
        List sqls = new ArrayList();
        String id = db.GenerateID("PollOption");
        for (int i = 0; i < ops.size(); i++) {
            ops.get(i).setoID(String.format("%06d", Integer.valueOf(id) + i));
            String sql = "INSERT INTO PollOption (Option_ID, Option_Poll, Option_Poll_Type, Option_Content, Option_SubCon) VALUES";
            sql += "('" + ops.get(i).getoID() + "', '" + ops.get(i).getpID() + "', '" + ops.get(i).getpType() + "', '" + ops.get(i).getoContent() + "', '" + ops.get(i).getSubCon() + "')";
            sqls.add(sql);
        }
        if (!sqls.isEmpty()) {
            re = db.ExecuteSQL2(sqls);
        }
        return re;
    }

    public PollBean SelAPoll(String pid) {
        PollBean pb = new PollBean();
        String sql = "select count(*) as num from poll where Poll_ID='" + pid + "'";
        ResultSet rs = db.ExecuteSQL(sql);
        try {
            rs.next();
            if (Integer.parseInt(rs.getString("num")) == 1) {
                sql = "select * from poll where Poll_ID='" + pid + "'";
                rs = db.ExecuteSQL(sql);
// Poll_ID varchar(100) primary key,   //Poll_Title varchar(100),  //Poll_Description varchar(100),
//Poll_Initiator varchar(100),   //Poll_Type int,  //Poll_Lastmodify varchar(100),
//Poll_Descsion varchar(100),  //Poll_Status int
                rs.next();
                pb = new PollBean();
                pb.setPoll_ID(pid);
                pb.setPoll_Title(rs.getString("Poll_Title").trim());
                pb.setPoll_Description(rs.getString("Poll_Description").trim());
                pb.setPoll_Type(rs.getString("Poll_Type").trim());
                pb.setPoll_Initiator(rs.getString("Poll_Initiator").trim());
                pb.setPoll_Lastmodify(rs.getString("Poll_Lastmodify").trim());
                pb.setPoll_Status(rs.getString("Poll_Status").trim());
                pb.setPoll_Descsion(rs.getString("Poll_Descsion").trim());
            }
        } catch (Exception ex) {
        }
        return pb;
    }

    public ArrayList<OptionBean> SelOptions(String pid) {
        ArrayList<OptionBean> ops = new ArrayList<OptionBean>();
        //select * from polloption where Option_Poll='000016' order by Option_ID
        String sql = "select count(*) as num from PollOption where Option_Poll='" + pid + "' order by Option_ID";
        try {
            ResultSet rs = db.ExecuteSQL(sql);
            rs.next();
            if (Integer.parseInt(rs.getString("num")) >= 1) {
                sql = "select * from PollOption where Option_Poll='" + pid + "' order by Option_ID";
                rs = db.ExecuteSQL(sql);

                while (rs.next()) {
                    OptionBean ob = new OptionBean();
//Option_ID varchar(100) primary key,
//Option_Poll varchar(100),
//Option_Poll_Type varchar(100),
//Option_Content varchar(100),
//Option_SubCon varchar(100)
                    ob.setoID(rs.getString("Option_ID").trim());
                    ob.setpID(rs.getString("Option_Poll").trim());
                    ob.setpType(rs.getString("Option_Poll_Type").trim());
                    ob.setoContent(rs.getString("Option_Content").trim());
                    ob.setSubCon(rs.getString("Option_SubCon").trim());
                    ops.add(ob);
                }
            }
        } catch (Exception ex) {
        }
        return ops;
    }

    public ArrayList<Vote> SelVotes(String pid) {
        ArrayList<Vote> vts = new ArrayList<Vote>();
        String sql = "select count(*) as num from vote where Vote_Poll = '" + pid + "' order by Vote_ID";
        try {
            ResultSet rs = db.ExecuteSQL(sql);
            rs.next();
            if (Integer.parseInt(rs.getString("num")) >= 1) {
                sql = "select * from vote where Vote_Poll = '" + pid + "' order by Vote_ID";
                rs = db.ExecuteSQL(sql);
                while (rs.next()) {
                    Vote vt = new Vote();
//                 Vote_ID varchar(100) primary key,
//Vote_Creator varchar(100),
//Vote_Option varchar(100),
//Vote_Poll varchar(100)

                    vt.setVote_ID(rs.getString("Vote_ID").trim());
                    vt.setVote_Creator(rs.getString("Vote_Creator").trim());
                    vt.setVote_Option(rs.getString("Vote_Option").trim());
                    vt.setVote_Poll(pid);

                    vts.add(vt);
                }
            }
        } catch (Exception ex) {
        }
        return vts;
    }

    public ArrayList<Comment> SelComments(String pid) {
        ArrayList<Comment> commts = new ArrayList<Comment>();
        String sql = "select count(*) as num from Comment where Comment_Poll = '" + pid + "' order by Comment_ID";
        try {
            ResultSet rs = db.ExecuteSQL(sql);
            rs.next();
            if (Integer.parseInt(rs.getString("num")) >= 1) {
                sql = "select * from Comment where Comment_Poll = '" + pid + "' order by Comment_ID";
                rs = db.ExecuteSQL(sql);
                while (rs.next()) {
                    Comment comt = new Comment();

                    comt.setComment_ID(rs.getString("Comment_ID").trim());
                    comt.setComment_Poll(rs.getString("Comment_Poll").trim());
                    comt.setComment_Content(rs.getString("Comment_Content").trim());
                    comt.setComment_Creator(rs.getString("Comment_Creator").trim());
                    comt.setComment_DateTime(rs.getString("Comment_DateTime").trim());

                    commts.add(comt);
                }
            }
        } catch (Exception ex) {
        }
        return commts;
    }

    public int InsertVote(Vote vt) {
        int tag = 0;
        String sql = "select count(*) num  from Vote where Vote_Creator='" + vt.getVote_Creator() + "' and  Vote_Poll='" + vt.getVote_Poll() + "' ";
        ResultSet rs = db.ExecuteSQL(sql);
        try {
            rs.next();
            if (Integer.parseInt(rs.getString("num")) < 1) {
                sql = "Update Poll set Poll_Status ='2' where Poll_ID ='" + vt.getVote_Poll() + "'";
                db.ExecuteSQL2(sql);

                vt.setVote_ID(db.GenerateID("Vote"));
                sql = " INSERT INTO Vote (Vote_ID, Vote_Creator, Vote_Option, Vote_Poll) ";
                sql += "VALUES ('" + vt.getVote_ID() + "', '" + vt.getVote_Creator() + "', '" + vt.getVote_Option() + "', '" + vt.getVote_Poll() + "')";
                tag = db.ExecuteSQL2(sql);
            }
            // vt.setVote_ID(db.GenerateID("Vote"));
            //String sql = " INSERT INTO Comment (Comment_ID, Comment_Poll, Comment_Creator, Comment_Content, Comment_DateTime) ";
            //sql += "VALUES ('"+comm.getComment_ID()+"', '"+comm.getComment_Poll()+"', '"+comm.getComment_Creator()+"', '"+comm.getComment_Content()+"', '"+comm.getComment_DateTime()+"')";
        } catch (Exception ex) {
        }
        return tag;
    }

    public int InsertComm(Comment comm) {
        int tag = 0;
        String sql = "";

        try {
            sql = "Update Poll set Poll_Status ='2' where Poll_ID ='" + comm.getComment_Poll() + "'";
            db.ExecuteSQL2(sql);

            comm.setComment_ID(db.GenerateID("Comment"));
            sql = " INSERT INTO Comment (Comment_ID, Comment_Poll, Comment_Creator, Comment_Content, Comment_DateTime) ";
            sql += "VALUES ('" + comm.getComment_ID() + "', '" + comm.getComment_Poll() + "', '" + comm.getComment_Creator() + "', '" + comm.getComment_Content() + "', '" + comm.getComment_DateTime() + "')";
            tag = db.ExecuteSQL2(sql);
        } catch (Exception ex) {
        }
        return tag;
    }

    public int DeleteComm(String commid) {
        int tag = 0;
        tag = db.ExecuteSQL2("DELETE FROM Comment WHERE Comment_ID = '" + commid + "'");
        return tag;
    }

    public int UpdateComm(Comment comm) {
        int tag = 0;
        tag = db.ExecuteSQL2("Update Comment set Comment_Content='" + comm.getComment_Content().trim() + "'  WHERE Comment_ID = '" + comm.getComment_ID().trim() + "'");
        return tag;
    }

    public int DeleteVote(String voteid) {
        int tag = 0;
        tag = db.ExecuteSQL2("DELETE FROM Vote WHERE Vote_ID = '" + voteid + "'");
        return tag;
    }

    public int UpdateVote(Vote vt) {
        int tag = 0;
        tag = db.ExecuteSQL2("Update Vote set Vote_Option='" + vt.getVote_Option() + "' WHERE Vote_ID = '" + vt.getVote_ID() + "'");
        return tag;
    }

    public ArrayList<PollBean> SelMyVotes(String uid) {
        ArrayList<PollBean> pbs = new ArrayList<PollBean>();
        String sql = "select count(distinct(Poll_ID)) as num  from Poll left join Vote on Poll.Poll_ID = Vote.Vote_Poll where Vote.Vote_Creator='" + uid + "'";
        try {
            ResultSet rs = db.ExecuteSQL(sql);
            rs.next();
            if (Integer.parseInt(rs.getString("num")) >= 1) {
                sql = "select distinct(Poll_ID) as Poll_ID,Poll_Title,Poll_Description,Poll_Type,Poll_Initiator,Poll_Lastmodify,Poll_Status,Poll_Descsion from Poll left join Vote on Poll.Poll_ID = Vote.Vote_Poll where Vote.Vote_Creator='" + uid + "'";

                rs = db.ExecuteSQL(sql);
                while (rs.next()) {
                    PollBean pb = new PollBean();
                    pb.setPoll_ID(rs.getString("Poll_ID").trim());
                    pb.setPoll_Title(rs.getString("Poll_Title").trim());
                    pb.setPoll_Description(rs.getString("Poll_Description").trim());
                    pb.setPoll_Type(rs.getString("Poll_Type").trim());
                    pb.setPoll_Initiator(rs.getString("Poll_Initiator").trim());
                    pb.setPoll_Lastmodify(rs.getString("Poll_Lastmodify").trim());
                    pb.setPoll_Status(rs.getString("Poll_Status").trim());
                    pb.setPoll_Descsion(rs.getString("Poll_Descsion").trim());
                    pbs.add(pb);
                }
            }
        } catch (Exception ex) {
        }
        return pbs;
    }

    public ArrayList<PollBean> SelMyPolls(String uid) {
        ArrayList<PollBean> pbs = new ArrayList<PollBean>();
        String sql = "select count(*) num from Poll where Poll_Initiator ='" + uid + "' order by Poll_ID desc";
        try {
            ResultSet rs = db.ExecuteSQL(sql);
            rs.next();
            if (Integer.parseInt(rs.getString("num")) >= 1) {
                sql = "select * from Poll where Poll_Initiator ='" + uid + "' order by Poll_ID desc";

                rs = db.ExecuteSQL(sql);
                while (rs.next()) {
                    PollBean pb = new PollBean();
                    pb.setPoll_ID(rs.getString("Poll_ID").trim());
                    pb.setPoll_Title(rs.getString("Poll_Title").trim());
                    pb.setPoll_Description(rs.getString("Poll_Description").trim());
                    pb.setPoll_Type(rs.getString("Poll_Type").trim());
                    pb.setPoll_Initiator(rs.getString("Poll_Initiator").trim());
                    pb.setPoll_Lastmodify(rs.getString("Poll_Lastmodify").trim());
                    pb.setPoll_Status(rs.getString("Poll_Status").trim());
                    pb.setPoll_Descsion(rs.getString("Poll_Descsion").trim());
                    pbs.add(pb);
                }
            }
        } catch (Exception ex) {
        }
        return pbs;
    }

    public int DeletePoll(String pollid) {
        int tag = 0;
        tag = db.ExecuteSQL2("DELETE FROM Poll WHERE Poll_ID = '" + pollid + "'");
        return tag;
    }

    public String UpdatePoll(PollBean pb) {
        //INSERT INTO Poll (Poll_ID, Poll_Title, Poll_Description, Poll_Initiator, Poll_Type, Poll_Lastmodify, Poll_Descsion, Poll_Status) 
        //VALUES ('1', '2', '3', '4', '5', 'a', 'b', 'c')
        String re = ""; // correct
        int tag = -1;


        String sql = "UPDATE Poll SET Poll_Title = '" + pb.getPoll_Title().trim() + "', Poll_Description = '" + pb.getPoll_Description() + "', Poll_Initiator = '" + pb.getPoll_Initiator() + "', Poll_Type = '" + pb.getPoll_Type() + "', Poll_Lastmodify = '" + pb.getPoll_Lastmodify() + "', Poll_Status = '" + pb.getPoll_Status() + "' WHERE Poll_ID = '" + pb.getPoll_ID() + "' ";
        tag = db.ExecuteSQL2(sql);
        if (tag != 0) {
            re = pb.getPoll_ID();
        }
        return re;
    }

    public int Deleteoption(String pollid) {
        int tag = 0;
        tag = db.ExecuteSQL2("DELETE FROM PollOption WHERE Option_Poll = '" + pollid + "'");
        return tag;
    }

    public String ClosePoll(PollBean pb) {
        //INSERT INTO Poll (Poll_ID, Poll_Title, Poll_Description, Poll_Initiator, Poll_Type, Poll_Lastmodify, Poll_Descsion, Poll_Status) 
        //VALUES ('1', '2', '3', '4', '5', 'a', 'b', 'c')
        String re = ""; // correct
        int tag = -1;


        String sql = "UPDATE Poll SET Poll_Status = '" + pb.getPoll_Status() + "', Poll_Descsion ='" + pb.getPoll_Descsion() + "' WHERE Poll_ID = '" + pb.getPoll_ID() + "' ";
        tag = db.ExecuteSQL2(sql);
        if (tag != 0) {
            re = pb.getPoll_ID();
        }
        return re;
    }

    public void ReleaseO() {
        db.SQLRelase();
    }
}
