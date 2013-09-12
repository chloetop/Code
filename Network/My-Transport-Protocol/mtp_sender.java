
import java.io.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this template, choose Tools | Templates and open the template in
 * the editor.
 *
 *
 * import java.io.*; import java.util.logging.Level; import
 * java.util.logging.Logger;
 *
 * /**
 *
 * @author Administrator
 */
public class mtp_sender {

    //input
    static InetAddress Receiver_Host_IP;
    static int Receiver_Port;
    static String FileName;
    static int MWS;
    static int MSS;
    static int timeout;
    static float pdrop;
    static int seed;
    // necessary parameters
    static String File_Content = "";
    static List<String> sgm = new ArrayList<String>();
    static int[] seg_status;
    static DatagramSocket socket = null;
    static int SYN = 1;
    static int seq = 0;
    static int ack = 0;
    static Random random;

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {

        // TODO code application logic here

        try {
            Receiver_Host_IP = InetAddress.getByName(args[0]);
            Receiver_Port = Integer.parseInt(args[1]);
            FileName = args[2];
            MWS = Integer.parseInt(args[3]) / Integer.parseInt(args[4]);
            MSS = Integer.parseInt(args[4]);
            timeout = Integer.parseInt(args[5]);
            pdrop = Float.parseFloat(args[6]);
            seed = Integer.parseInt(args[7]);
            deletelog();
        } catch (Exception ex) {
            ex.printStackTrace();
            return;
        }
        
        System.out.println(Receiver_Host_IP.toString());
        System.out.println(Receiver_Port);
        System.out.println(FileName);
        System.out.println(MWS);
        System.out.println(MSS);
        System.out.println(timeout);
        System.out.println(pdrop);
        System.out.println(seed);
        random = new Random(seed);
        ReadFile(FileName);
        ConvertToSegment();
        // for(int i = 0; i<sgm.size();i++)
        //   System.out.println(sgm.get(i));

//        for (int j = 0; j < sgm.size(); j++) {
//            System.out.println(seg_status[j]);
//        }


//        try {
//            ByteArrayOutputStream out = new ByteArrayOutputStream();
//            ObjectOutputStream os = new ObjectOutputStream(out);
//            os.writeObject(S_mess);
//            //out.toByteArray();
//
//            ByteArrayInputStream in = new ByteArrayInputStream(out.toByteArray());
//            ObjectInputStream is = new ObjectInputStream(in);
//            // is.readObject();
//            System.out.println(is.readObject());
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }

        mtp_sender ms = new mtp_sender();


        //   new Thread(ms.new UDPClientFunc()).start();
        new Thread(ms.new UDPReliableFunc()).start();
        // UDPConnection();

    }

    public static void ConvertToSegment() {
        int Length = File_Content.getBytes().length;
        for (int i = 0;; i = i + MSS) {
            String str = "";
            if (i + MSS > Length) {
                str = File_Content.subSequence(i, Length).toString();
            } else {
                str = File_Content.subSequence(i, i + MSS).toString();
            }
            sgm.add(str);
            if (i + MSS > Length) {
                seg_status = new int[sgm.size()];
                for (int j = 0; j < sgm.size(); j++) {
                    seg_status[j] = 0;
                }
                break;
            }
        }
    }

    public static void UDPConnection(DatagramSocket socket) {
        try {
            Log(" start to build an connection, \r\nReceiver_Host_IP:" + Receiver_Host_IP + "  Receiver_Port:" + Receiver_Port);
            Date d1 = new java.util.Date();
            socket = new DatagramSocket();
            // handshake step 1
           
            while(true){
                 seq = (int)(Math.random()*95);
                 if(seq <100)
                     break;
            }
            String StrSender = SYN + "--" + seq + "--" + MSS + "--" + sgm.size() + "--0--";
            byte[] buf = StrSender.getBytes();
            DatagramPacket sender = new DatagramPacket(buf, buf.length, Receiver_Host_IP, Receiver_Port);
            socket.send(sender);
            DatagramPacket request = new DatagramPacket(new byte[32], 32);
            socket.receive(request);
            String str = new String(request.getData());
            str = str.trim();
         //   Log("Connection built, step 2\r\n SYN:" + str.split("-")[0] + " Ack:" + str.split("-")[1] + " NoData");
            System.out.println(str);
            System.out.println(str.length());
            SYN = 0;
            seq = seq + 1;

        } catch (Exception ex) {
          //  Log("connection fail");
        }
    }

    public class UDPReliableFunc implements Runnable {

        @Override
        public void run() {
            try {
                socket = new DatagramSocket();
                UDPConnection(socket);


            } catch (Exception ex) {
                ex.printStackTrace();
            }
            // handshake step 3
            String StrSender = SYN + "--" + seq + "--" + MSS + "--" + sgm.size() + "--0--";
            byte[] buf = StrSender.getBytes();
            DatagramPacket sender = new DatagramPacket(buf, buf.length, Receiver_Host_IP, Receiver_Port);

            try {
                socket.send(sender);
                Log("Connection built");
                socket.setSoTimeout(timeout);
            } catch (Exception ex) {
                ex.printStackTrace();
                Log("Connection fail, step 3");
            }


//                socket.receive(request);
//                String str = new String(request.getData());
//                str = str.trim();
//                System.out.println(str);
            int win_start = 0;
            int seqbase = 0;
            while(true){
                seqbase = (int)(Math.random()*1000);
                if(seqbase >=100)
                    break;
            }
            seq = seqbase;
            ack = 0;
            while (true) {
                DatagramPacket request = new DatagramPacket(new byte[32], 32);
                try {
                    try {
                        socket.receive(request);
                    } catch (SocketTimeoutException ex) {
                        System.out.println("outoftime.......");
                        for (int i = win_start; i < MWS + win_start; i++) // start to send segments
                        {
                            if (i >= sgm.size()) {
                                continue;
                            }

//                            StrSender = SYN + "--" + seq + "--" + sgm.get(i) + "--" + i + "--";

                            if (seg_status[i] == 1) {
//                                if (Drop() == 1) {
//                                    StrSender = StrSender + "0--";
//                                } else {
//                                    StrSender = StrSender + "1--";
//                                }
                                seq = i * MSS + seqbase;
                                StrSender = SYN + "--" + seq + "--" + sgm.get(i) + "--" + i + "--" + Drop() + "--";
                                buf = StrSender.getBytes();
                                DatagramPacket MessagesOFWindow = new DatagramPacket(buf, buf.length, Receiver_Host_IP, Receiver_Port);
                                socket.send(MessagesOFWindow);
                                seg_status[i] = 1; //0 data not sent 1 data sent  2 ack received
                                System.out.println(StrSender);
                                Log("retransmit the segment\r\n SYN:" + SYN + " Seq:" + seq + " Data:" + sgm.get(i));
                            }
                        }
                        continue;

                    }
                    String str = new String(request.getData());
                    str = str.trim();
                    // start send UDP messages with segments 
                    System.out.println(str);
                    if (Integer.parseInt(str.split("-")[0]) == 0) {
                        if (Integer.parseInt(str.split("-")[1]) >= 100) {
                            // update window info to indentify the beginning of window
                            seg_status[Integer.parseInt(str.split("-")[3])] = 2;
                            Log("ACK receive\r\n SYN:" + Integer.parseInt(str.split("-")[0]) + " Ack:" + Integer.parseInt(str.split("-")[1]) + " NoData");
                            int index = Integer.parseInt(str.split("-")[3]);

                            // update window starting index
                            for (int k = 0; k < sgm.size(); k++) {
                                if (seg_status[k] == 2) {
                                    win_start = k + 1;
                                } else {
                                    break;
                                }
                            }

                            // ack received............
                        }
                        // socket.setSoTimeout(timeout);
                        for (int i = win_start; i < MWS + win_start; i++) // start to send segments
                        {
                            //seg_status
                            if (i >= sgm.size()) // transfer is done
                            {
                                int tag = 0;
                                for (int k = 0; k < sgm.size(); k++) {
                                    if (seg_status[k] != 2) {
                                        tag = 1;
                                        break;
                                    }
                                }
                                if (tag == 0) {
                                    StrSender = "2--" + seq + "--0--0--0--";
                                    buf = StrSender.getBytes();
                                    DatagramPacket CloseMessage = new DatagramPacket(buf, buf.length, Receiver_Host_IP, Receiver_Port);
                                    socket.send(CloseMessage);
                                    Log("Transmission done, Socket closed");
                                    System.exit(0);
                                    break;
                                } else {
                                    continue;
                                }
                            }

                            // StrSender = SYN + "--" + seq + "--" + sgm.get(i) + "--" + i + "--";

                            if (seg_status[i] == 0) {
//                                if (Drop() == 1) {
//                                    StrSender = StrSender + "0--";
//                                } else {
//                                    StrSender = StrSender + "1--";
//                                }
                                seq = i * MSS + seqbase;
                                StrSender = SYN + "--" + seq + "--" + sgm.get(i) + "--" + i + "--" + Drop() + "--";
                                buf = StrSender.getBytes();
                                DatagramPacket MessagesOFWindow = new DatagramPacket(buf, buf.length, Receiver_Host_IP, Receiver_Port);
                                socket.send(MessagesOFWindow);
                                seg_status[i] = 1; //0 data not sent 1 data sent  2 ack received
                                System.out.println(StrSender);
                                Log("transmit the segment\r\n SYN:" + SYN + " Seq:" + seq + " Data:" + sgm.get(i));
                            }
                        }
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }

        }
    }

    public static int Drop() {
        int tag = 0; // 0 send  1 drop
        float x = random.nextFloat();
        if (x <= pdrop) {
            tag = 1;
        }
        System.out.println("x=" + x);
        return tag;
    }

    public static void ReadFile(String filename) {
        try {
            String thisLine;
            FileInputStream fin = new FileInputStream(filename);
            DataInputStream myInput = new DataInputStream(fin);
            while ((thisLine = myInput.readLine()) != null) {  // while loop begins here
                //   System.out.println(thisLine);
                File_Content += thisLine+"\n";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void WriteFile(String Con, String filename) {
        FileOutputStream fout = null;
        try {
            fout = new FileOutputStream(filename, true);
            PrintStream myOutput = new PrintStream(fout);
            myOutput.println(Con);

        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            try {
                fout.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
 public static void WriteFile2(String Con, String filename) {
        FileOutputStream fout = null;
        try {
            fout = new FileOutputStream(filename);
            PrintStream myOutput = new PrintStream(fout);
            myOutput.println(Con);

        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } finally {
            try {
                fout.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
    public static void Log(String str) {
        SimpleDateFormat simpledataformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        long timeInMillis = System.currentTimeMillis();
        String Cur_time = simpledataformat.format(new Date(timeInMillis));
        String logtext = Cur_time + ": " + str;
        WriteFile(logtext, "mtp_sender_log.txt");
        WriteFile("-------------------------------------------------\r\n", "mtp_sender_log.txt");
    }
    public static void deletelog(){
    File file = new File("mtp_sender_log.txt");
    if(file.isFile()&&file.exists())
        file.delete();
    }
}
