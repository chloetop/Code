/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package standard;

/**
 *
 * @author viennayy
 */
public class PollBean {
//    Poll_ID varchar(100) primary key,
//Poll_Title varchar(100),
//Poll_Description varchar(100),
//Poll_Initiator varchar(100),
//Poll_Type int,
//Poll_Lastmodify varchar(100),
//Poll_Descsion varchar(100),
//Poll_Status int
        
    private String Poll_ID="";
    private String Poll_Title="";
    private String Poll_Description="";
    private String Poll_Initiator="";
    private String Poll_Type="";
    private String Poll_Lastmodify="";
    private String Poll_Descsion="";
    private String Poll_Status ="";

    public String getPoll_ID() {
        return Poll_ID;
    }

    public void setPoll_ID(String Poll_ID) {
        this.Poll_ID = Poll_ID;
    }

    public String getPoll_Title() {
        return Poll_Title;
    }

    public void setPoll_Title(String Poll_Title) {
        this.Poll_Title = Poll_Title;
    }

    public String getPoll_Description() {
        return Poll_Description;
    }

    public void setPoll_Description(String Poll_Description) {
        this.Poll_Description = Poll_Description;
    }

    public String getPoll_Initiator() {
        return Poll_Initiator;
    }

    public void setPoll_Initiator(String Poll_Initiator) {
        this.Poll_Initiator = Poll_Initiator;
    }

    public String getPoll_Type() {
        return Poll_Type;
    }

    public void setPoll_Type(String Poll_Type) {
        this.Poll_Type = Poll_Type;
    }

    public String getPoll_Lastmodify() {
        return Poll_Lastmodify;
    }

    public void setPoll_Lastmodify(String Poll_Lastmodify) {
        this.Poll_Lastmodify = Poll_Lastmodify;
    }

    public String getPoll_Descsion() {
        return Poll_Descsion;
    }

    public void setPoll_Descsion(String Poll_Descsion) {
        this.Poll_Descsion = Poll_Descsion;
    }

    public String getPoll_Status() {
        return Poll_Status;
    }

    public void setPoll_Status(String Poll_Status) {
        this.Poll_Status = Poll_Status;
    }

  
}
