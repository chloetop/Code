/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package standard;

/**
 *
 * @author Administrator
 */
public class Comment {
//    Comment_ID varchar(100) primary key,
//Comment_Poll varchar(100),
//Comment_Creator varchar(100),
//Comment_Content varchar(100),
//Comment_DateTime varchar(100)
    
    private String Comment_ID = "";
    private String Comment_Poll = "";
    private String Comment_Creator = "";
    private String Comment_Content = "";
    private String Comment_DateTime = "";

    public String getComment_ID() {
        return Comment_ID;
    }

    public void setComment_ID(String Comment_ID) {
        this.Comment_ID = Comment_ID;
    }

    public String getComment_Poll() {
        return Comment_Poll;
    }

    public void setComment_Poll(String Comment_Poll) {
        this.Comment_Poll = Comment_Poll;
    }

    public String getComment_Creator() {
        return Comment_Creator;
    }

    public void setComment_Creator(String Comment_Creator) {
        this.Comment_Creator = Comment_Creator;
    }

    public String getComment_Content() {
        return Comment_Content;
    }

    public void setComment_Content(String Comment_Content) {
        this.Comment_Content = Comment_Content;
    }

    public String getComment_DateTime() {
        return Comment_DateTime;
    }

    public void setComment_DateTime(String Comment_DateTime) {
        this.Comment_DateTime = Comment_DateTime;
    }
}
