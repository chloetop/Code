/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package standard;

/**
 *
 * @author Administrator
 */
public class OptionBean {
//    create table PollOption(
//Option_ID varchar(100) primary key,
//Option_Poll varchar(100),
//Option_Poll_Type varchar(100),
//Option_Content varchar(100),
//Option_SubCon varchar(100)
//);

    private String oID = "";
    private String pID = "";
    private String pType = "";
    private String oContent = "";
    private String SubCon = "";

    public String getoID() {
        return oID;
    }

    public void setoID(String oID) {
        this.oID = oID;
    }

    public String getpID() {
        return pID;
    }

    public void setpID(String pID) {
        this.pID = pID;
    }

    public String getpType() {
        return pType;
    }

    public void setpType(String pType) {
        this.pType = pType;
    }

    public String getoContent() {
        return oContent;
    }

    public void setoContent(String oContent) {
        this.oContent = oContent;
    }

    public String getSubCon() {
        return SubCon;
    }

    public void setSubCon(String SubCon) {
        this.SubCon = SubCon;
    }
}
