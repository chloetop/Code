/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package standard;

import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class Jobj {
    private PollBean pb = new PollBean();
    private ArrayList<OptionBean> ops = new ArrayList<OptionBean>();
    private ArrayList<Vote> vts = new ArrayList<Vote>();
    private ArrayList<Comment> comms = new ArrayList<Comment>();

    public Jobj(PollBean pb,ArrayList<OptionBean> ops,ArrayList<Vote> vts,ArrayList<Comment> comms){
        this.setPb(pb);
        this.setOps(ops);
        this.setVts(vts);
        this.setComms(comms);
    
    }
    public PollBean getPb() {
        
        return pb;
    }

    public void setPb(PollBean pb) {
        this.pb = pb;
    }

    public ArrayList<OptionBean> getOps() {
        return ops;
    }

    public void setOps(ArrayList<OptionBean> ops) {
        this.ops = ops;
    }

    public ArrayList<Vote> getVts() {
        return vts;
    }

    public void setVts(ArrayList<Vote> vts) {
        this.vts = vts;
    }

    public ArrayList<Comment> getComms() {
        return comms;
    }

    public void setComms(ArrayList<Comment> comms) {
        this.comms = comms;
    }
    
   
}
