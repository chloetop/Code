/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.*;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class mtp_receiver {

    /**
     * @param args the command line arguments
     */
    static int Receiver_Port;
    static String FileName;
    static String[] data;
    static String allseq ="";

    public static void main(String[] args) {
        // TODO code application logic here
        try {
            Receiver_Port = Integer.parseInt(args[0]);
            FileName = args[1];
           
        } catch (Exception ex) {
            ex.printStackTrace();
            return;
        }
        System.out.println(Receiver_Port);
        System.out.println(FileName);
//        String s="0--100--Day after day, week after week, passed away on my return to Geneva; and I could not collect the courage to recommence my work. I feared the vengeance ---1--";
//        for(int j=0;j<s.split("--").length;j++)
//            System.out.println(s.split("--")[j]);
        DatagramSocket socket = null;
        try {
            socket = new DatagramSocket(Receiver_Port);

            DatagramPacket request = new DatagramPacket(new byte[32], 32);

            int ack = 0;
            int size = 0;
            // Processing loop.
            while (true) {
                // handshake step 2
                request = new DatagramPacket(new byte[32 + size], 32 + size);
                socket.receive(request);
                String str = new String(request.getData());
                str = str.trim();

                System.out.println(str);
                System.out.println(str.length());
                ack = Integer.parseInt(str.split("--")[1]) + str.length();

                InetAddress clientHost = request.getAddress();
                int clientPort = request.getPort();

                byte[] buf = null;
                String response = "";
                // transfer is done
                if (Integer.parseInt(str.split("--")[0]) == 2) {
                    System.out.println("done");

                    String Text = "";
                    for (int i = 0; i < data.length; i++) {
                        Text = Text + data[i];
                    }
                    WriteFile(Text, FileName);
                    Log("Transmission done,File created ");
                    ReadFile(FileName);
                    System.out.println("Seq num:"+allseq);
                    ack = 0;
                    size = 0;
                    allseq = "";
                    continue;
                }
                // building a connection
                if (Integer.parseInt(str.split("--")[0]) == 1) {
                    ack = Integer.parseInt(str.split("--")[1]);
                    response = "1-" + ack + "-NoData-0";

                    size = Integer.parseInt(str.split("--")[2]);
                    request = new DatagramPacket(new byte[32 + size], 32 + size);
                    data = new String[Integer.parseInt(str.split("--")[3])];
                    Log("Request of connection received");
                } else if (Integer.parseInt(str.split("--")[0]) == 0) {  // transfer a file
                    // clientPort = Integer.parseInt(str.split("-")[4]);
                    ack = Integer.parseInt(str.split("--")[1]);
                    if (Integer.parseInt(str.split("--")[1]) >= 100) {

                        response = "0-" + ack + "-NoData-" + Integer.parseInt(str.split("--")[3]);
                        if (Integer.parseInt(str.split("--")[4]) == 0) {
                            data[Integer.parseInt(str.split("--")[3])] = str.split("--")[2];
                            Log("Segment received\r\n SYN:" + str.split("--")[0] + " Seq:" + str.split("--")[1] + " Data:" + str.split("--")[2]);
                            allseq = allseq+"->"+str.split("--")[1];
                        }
                    } else {
                        response = "0-" + ack + "-NoData-0";
                        //Log("connection built,step 3\r\n SYN:" + str.split("--")[0] + " Seq:" + str.split("--")[1] + " NoData");
                    }
                }

                buf = response.getBytes();
                DatagramPacket reply = new DatagramPacket(buf, buf.length, clientHost, clientPort);
                if (Integer.parseInt(str.split("--")[4]) == 0) {
                    socket.send(reply);
                    System.out.println(response);

                } else {
                    System.out.println("drop...........");
                }


            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }






    }

    public static void WriteFile(String Con, String filename) {
        FileOutputStream fout = null;
        try {
            if ("mtp_receiver_log.txt".equals(filename)) {
                fout = new FileOutputStream(filename, true);
                PrintStream myOutput = new PrintStream(fout);
                myOutput.println(Con);
            } else {
                fout = new FileOutputStream(filename);
                PrintStream myOutput = new PrintStream(fout);
                myOutput.print(Con);
            }


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

    public static void ReadFile(String filename) {
        try {
            String thisLine;
            String File_Content = "";
            FileInputStream fin = new FileInputStream(filename);
            DataInputStream myInput = new DataInputStream(fin);
            while ((thisLine = myInput.readLine()) != null) {  // while loop begins here
                //   System.out.println(thisLine);
                File_Content += thisLine;
            }
            System.out.println(File_Content);
            System.out.println(File_Content.length());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void Log(String str) {
        SimpleDateFormat simpledataformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        long timeInMillis = System.currentTimeMillis();
        String Cur_time = simpledataformat.format(new Date(timeInMillis));
        String logtext = Cur_time + ": " + str;
        WriteFile(logtext, "mtp_receiver_log.txt");
        WriteFile("-------------------------------------------------\r\n", "mtp_receiver_log.txt");
    }

    public static void deletelog() {
        File file = new File("mtp_receiver_log.txt");
        if (file.isFile() && file.exists()) {
            file.delete();
        }
    }
}
