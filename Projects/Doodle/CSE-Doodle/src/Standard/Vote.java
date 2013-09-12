/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package standard;

/**
 *
 * @author Administrator
 */
public class Vote {
//    Vote_ID varchar(100) primary key,
//Vote_Creator varchar(100),
//Vote_Option varchar(100)
    //Vote_Poll varchar(100)
    private String Vote_ID = "";
    private String Vote_Creator = "";
    private String Vote_Option = "";
     private String Vote_Poll = "";
    
    public String getVote_ID() {
        return Vote_ID;
    }

    public void setVote_ID(String Vote_ID) {
        this.Vote_ID = Vote_ID;
    }

    public String getVote_Creator() {
        return Vote_Creator;
    }

    public void setVote_Creator(String Vote_Creator) {
        this.Vote_Creator = Vote_Creator;
    }

    public String getVote_Option() {
        return Vote_Option;
    }

    public void setVote_Option(String Vote_Option) {
        this.Vote_Option = Vote_Option;
    }

    public String getVote_Poll() {
        return Vote_Poll;
    }

    public void setVote_Poll(String Vote_Poll) {
        this.Vote_Poll = Vote_Poll;
    }
    
}
