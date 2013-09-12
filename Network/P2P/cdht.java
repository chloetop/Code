/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author yang yu z3342248
 */
public class cdht {

    /**
     * @param args the command line arguments
     */
    public static int peer1 = -1;
    public static int peer2 = -1;
    public static int peer3 = -1;
    public static int BasePort = 50000;
    public static InetAddress LocalIP;
    public static int localPort;
    public static int Successor1; // first successor's port
    public static int Successor2; // second successor's port
    public static int PrePeer1 = -1; //a closer peer sending request to current peer
    public static int PrePeer2 = -1; //a further peer sending request to current peer
    public static int Predecessor1; //port of closer peer
    public static int Predecessor2; // port of further peer
    public static int UDPstatus = 1;
    public static int TimesOfPing1 = 0; // sequence number of first successor
    public static int TimesOfPing2 = 0; // sequence number of sencond successor
    public static int TimesOfMiss1 = 0; // missing times of first successor
    public static int TimesOfMiss2 = 0; // missing times of second successor

    public static void main(String[] args) throws Exception {
        // TODO code application logic here
        if (args.length != 3) {
            System.out.println("3 Peers are required!");
            return;
        }
        //assume a peer itself is its indenty
        //start to initialize parameters
        peer1 = Integer.parseInt(args[0]);
        peer2 = Integer.parseInt(args[1]);
        peer3 = Integer.parseInt(args[2]);
        LocalIP = InetAddress.getLocalHost();
        localPort = BasePort + peer1;
        Successor1 = BasePort + peer2;
        Successor2 = BasePort + peer3;
        System.out.println("Peer1 = " + peer1);
        System.out.println("Peer2 = " + peer2);
        System.out.println("Peer3 = " + peer3);
        System.out.println("BasePort = " + BasePort);
        System.out.println("ip = " + LocalIP.getHostAddress());
        Timer timer = new Timer();
        //start UDP thread
        cdht cdht = new cdht();
       UDPClientFunc udptask = cdht.new UDPClientFunc();

        new Thread(cdht.new UDPServerFunc()).start();
        new Thread(cdht.new TCPServerFunc()).start();
        Thread.sleep(10000);
        timer.schedule(udptask, 1000, 20000);
        new Thread(cdht.new TCPClientFunc()).start();
    }

    // UDP request messages were sent periodically
    class UDPClientFunc extends TimerTask {

        @Override
        public void run() {
            try {
                if (UDPstatus == 0) {
                    return;
                }
                DatagramSocket socket = new DatagramSocket();
                socket.setSoTimeout(500);

                // send ping messages to Successor1 to chech if it is alive
                //request  format    from peer - to peer - times of ping -successor number
                byte[] buf = (String.valueOf(peer1) + "-" + String.valueOf(peer2) + "-" + TimesOfPing1 + "-1").getBytes();
                DatagramPacket request = new DatagramPacket(buf, buf.length, LocalIP, Successor1);
                socket.send(request);
                // listening from Successors, if there is a reponse, this means that successor is alive

                DatagramPacket response = new DatagramPacket(new byte[16], 16);
                // Block until the host receives a UDP packet.

                try {
                    socket.receive(response);
                    String str = new String(response.getData());
                    str = str.trim();
                    //   System.out.println(str);
                    System.out.println("A ping response message was received from Peer " + str.split("-")[0] + ".");
                    if (Integer.parseInt(str.split("-")[2]) == TimesOfPing1) {
                        TimesOfMiss1 = 0;
                    } else {
                        TimesOfMiss1++;
                    }

                } catch (SocketTimeoutException ex) {
                    TimesOfMiss1++;
                }
                //  System.out.println("Peer2  times of ping = " + TimesOfPing1 + " times of miss = " + TimesOfMiss1);
                TimesOfPing1++;

                // send ping messages to Successor2 to chech if it is alive
                buf = (String.valueOf(peer1) + "-" + String.valueOf(peer2) + "-" + TimesOfPing2 + "-2").getBytes();
                request = new DatagramPacket(buf, buf.length, LocalIP, Successor2);
                socket.send(request);
                response = new DatagramPacket(new byte[16], 16);
                // Block until the host receives a UDP packet.
                try {
                    socket.receive(response);
                    String str = new String(response.getData());
                    str = str.trim();
                    System.out.println("A ping response message was received from Peer " + str.split("-")[0] + ".");
                    if (Integer.parseInt(str.split("-")[2]) == TimesOfPing2) {
                        TimesOfMiss2 = 0;
                    } else {
                        TimesOfMiss2++;
                    }
                } catch (SocketTimeoutException ex) {
                    TimesOfMiss2++;
                }
                //  System.out.println("Peer3  times of ping = " + TimesOfPing2 + " times of miss = " + TimesOfMiss2);
                TimesOfPing2++;

                //////////////////////////////////not alive///////////////////////////////////////////////////
                // if times of missing is over 4, which means a successor is dead, and necessary to find a new successor
                if (TimesOfMiss1 >= 4) {
                    System.out.println("Peer " + peer2 + " is no longer alive. ");
                    peer2 = peer3;
                    Successor1 = peer2 + BasePort;
                    TimesOfPing1 = TimesOfPing2;
                    TimesOfMiss1 = TimesOfMiss2;
                    System.out.println("My first successor is now peer " + peer2 + ".");
                    Socket clientSocket = new Socket(LocalIP, Successor1);
                    clientSocket.setSoTimeout(500);
                    // write to server
                    DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
                    outToServer.writeBytes("search-" + peer1 + '\n');
                    clientSocket.close();

                    // notice other prepeer to update its successor
                    clientSocket = new Socket(LocalIP, Predecessor1);
                    clientSocket.setSoTimeout(500);
                    // write to server
                    outToServer = new DataOutputStream(clientSocket.getOutputStream());
                    outToServer.writeBytes("notice-" + peer2 + '\n');
                    clientSocket.close();
                }
                if (TimesOfMiss2 >= 4) {
                    System.out.println("Peer " + peer3 + " is no longer alive. ");
                }
            } catch (Exception ex) {
                //  ex.printStackTrace();
            }
        }
    }

    public class UDPServerFunc implements Runnable {

        @Override
        public void run() {
            try {
                DatagramSocket socket = new DatagramSocket(localPort);
                while (true) {
                    // Create a datagram packet to hold incomming UDP packet.
                    DatagramPacket request = new DatagramPacket(new byte[16], 16);

                    // Block until the host receives a UDP packet.
                    socket.receive(request);
                    // Print the recieved data.
                    String str = new String(request.getData());
                    str = str.trim();
                    // System.out.println("request is "+str);
                    System.out.println("A ping request message was received from Peer " + str.split("-")[0] + ".");
                    // record information about which peer send request messages to current peer
                    if (Integer.parseInt(str.split("-")[3]) == 1) {
                        PrePeer1 = Integer.parseInt(str.split("-")[0]);
                        Predecessor1 = PrePeer1 + BasePort;
                    }
                    if (Integer.parseInt(str.split("-")[3]) == 2) {
                        PrePeer2 = Integer.parseInt(str.split("-")[0]);
                        Predecessor2 = PrePeer2 + BasePort;
                    }

                    // send a response back to confirm that current peer is alive
                    int clientPort = request.getPort();
                    //UDP response format current peer-from peer-times of ping
                    byte[] buf = (String.valueOf(peer1) + "-" + str.split("-")[0] + "-" + str.split("-")[2]).getBytes();
                    DatagramPacket reply = new DatagramPacket(buf, buf.length, LocalIP, clientPort);
                    socket.send(reply);
                }
            } catch (Exception ex) {
            }
        }
    }

    public class TCPClientFunc implements Runnable {

        @Override
        public void run() {
            while (true) {

                String filename = "";
                try {
                    BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
                    String input = inFromUser.readLine();
                    String command = input.split(" ")[0];
                    // listen and get commands from users as input
                    if ("request".equals(command)) {
                        filename = input.split(" ")[1];
                        // send request to successors
                        // create socket which connects to server
                        System.out.println("File request message for " + filename + " has been sent to my successor.");
                        Socket clientSocket = new Socket(LocalIP, Successor1);
                        clientSocket.setSoTimeout(500);
                        // format request - file name - port of current peer - current peer id
                        DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
                        outToServer.writeBytes("request-" + filename + "-" + localPort + "-" + peer1 + '\n');
                        clientSocket.close();
                    }
                    if ("quit".equals(command)) {
                        //send departure message
                        Socket PreSocket = new Socket(LocalIP, Predecessor1);
                        PreSocket.setSoTimeout(500);
                        // send to Predecessors
                        //format  quit - current peer - first successor - second successor
                        DataOutputStream outToPre = new DataOutputStream(PreSocket.getOutputStream());
                        outToPre.writeBytes("quit-" + peer1 + "-" + peer2 + "-" + peer3 + '\n');
                        PreSocket = new Socket(LocalIP, Predecessor2);
                        outToPre = new DataOutputStream(PreSocket.getOutputStream());
                        outToPre.writeBytes("quit-" + peer1 + "-" + peer2 + "-" + peer3 + '\n');
                        // close  socket
                        PreSocket.close();
                        //make current peer stop sending request messages to successors
                        UDPstatus = 0;
                    }
                    // close client socket

                } catch (ConnectException ex) {
                } catch (Exception ex) {
                    // ex.printStackTrace();
                }

            }
        }
    }

    public class TCPServerFunc implements Runnable {

        @Override
        public void run() {
            try {
                // create server socket
                ServerSocket welcomeSocket = new ServerSocket(localPort);

                while (true) {

                    // accept connection from connection queue
                    Socket connectionSocket = welcomeSocket.accept();
                    // create read stream to get input
                    BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
                    String clientSentence;
                    clientSentence = inFromClient.readLine();
                    String Command = clientSentence.split("-")[0];
                    // receive a command to do the rest 

                    if ("request".equals(Command)) {
                        //checking file is in current peer or not
                        String filename = clientSentence.split("-")[1];
                        int initiator = Integer.parseInt(clientSentence.split("-")[2]);
                        int PrePeer = Integer.parseInt(clientSentence.split("-")[3]);
                        int HashFile = hashfile(filename);
                        //  System.out.println(HashFile);
                        int tag = 0; // 1= stored in current peer    0= not
                        if (peer1 == HashFile) {
                            tag = 1;
                        } else if (peer1 > HashFile) {
                            if (PrePeer < HashFile || (PrePeer > peer1 && peer2 > peer1)) {
                                tag = 1;
                            }
                        } else {
                            if (PrePeer > peer1 && HashFile > PrePeer) {
                                tag = 1;
                            }
                        }
                        if (tag == 1) { // file found
                            Socket InitSocket = new Socket(LocalIP, initiator);
                            InitSocket.setSoTimeout(500);
                            // write to initiator
                            DataOutputStream outToInitiator = new DataOutputStream(InitSocket.getOutputStream());
                            outToInitiator.writeBytes("found-" + filename + "-" + localPort + '\n');

                            System.out.println("File " + filename + " is here.");
                            System.out.println("A response message, destined for peer " + (initiator - BasePort) + ", has been sent.");
                            // close  socket
                            InitSocket.close();
                        } else { // forword request message to next peer
                            Socket NextSocket = new Socket(LocalIP, Successor1);
                            NextSocket.setSoTimeout(500);
                            // write to initiator
                            DataOutputStream outToNext = new DataOutputStream(NextSocket.getOutputStream());
                            outToNext.writeBytes("request-" + filename + "-" + initiator + "-" + peer1 + '\n');

                            System.out.println("File " + filename + " is not stored here");
                            System.out.println("File request message has been forwarded to my successor.");
                            // close  socket
                            NextSocket.close();
                        }
                    }
                    if ("found".equals(Command)) {
                        //initial peer receives a message from the peer who has the file
                        String filename = clientSentence.split("-")[1];
                        int destination = Integer.parseInt(clientSentence.split("-")[2]);
                        System.out.println("Received a response message from peer " + (destination - BasePort) + ", which has the file " + filename + ".");
                    }
                    if ("quit".equals(Command)) {

                        //   receive messages from a peer who departs, update current peer's successor information 
                        int OldPeer = Integer.parseInt(clientSentence.split("-")[1]);
                        int NewPeer1 = Integer.parseInt(clientSentence.split("-")[2]);
                        int NewPeer2 = Integer.parseInt(clientSentence.split("-")[3]);
                        if (peer2 == OldPeer) {
                            peer2 = peer3;
                            peer3 = NewPeer2;
                            Successor1 = peer2 + BasePort;
                            Successor2 = peer3 + BasePort;
                            TimesOfPing1 = TimesOfPing2;
                            TimesOfMiss1 = TimesOfMiss2;
                            TimesOfPing2 = 0;
                            TimesOfMiss2 = 0;
                        }
                        if (peer3 == OldPeer) {
                            peer3 = NewPeer1;
                            Successor2 = peer3 + BasePort;
                            TimesOfPing2 = 0;
                            TimesOfMiss2 = 0;
                        }
                        System.out.println("Peer " + OldPeer + " will depart from the network.");
                        System.out.println("My first successor is now peer " + peer2 + ".");
                        System.out.println("My second successor is now peer " + peer3 + ".");
                    }
                    // a  peer  will  declare  that  a  successor  is  not  alive  if  4  consecutive  ping messages  are  not  replied
                    if ("search".equals(Command)) {
                        // find next alive peer
                        int FromPeer = Integer.parseInt(clientSentence.split("-")[1]);
                        Socket ReSocket = new Socket(LocalIP, FromPeer + BasePort);
                        ReSocket.setSoTimeout(500);
                        // write to initiator
                        DataOutputStream outToNext = new DataOutputStream(ReSocket.getOutputStream());
                        outToNext.writeBytes("Result-" + peer2 + '\n');
                        // close  socket
                        ReSocket.close();
                    }
                    if ("Result".equals(Command)) {
                        //update successor information
                        int NewPeer = Integer.parseInt(clientSentence.split("-")[1]);
                        peer3 = NewPeer;
                        Successor2 = peer3 + BasePort;
                        TimesOfPing2 = 0;
                        TimesOfMiss2 = 0;
                        System.out.println("My second successor is now peer " + peer3 + ".");
                    }
                    if ("notice".equals(Command)) {
                        int NewPeer = Integer.parseInt(clientSentence.split("-")[1]);
                        peer3 = NewPeer;
                        Successor2 = peer3 + BasePort;
                        TimesOfPing2 = 0;
                        TimesOfMiss2 = 0;
                        System.out.println("My first successor is now peer " + peer2 + ".");
                        System.out.println("My second successor is now peer " + peer3 + ".");
                    }

                    // process input
//                    String capitalizedSentence;
//                    capitalizedSentence = clientSentence.toUpperCase() + '\n';

                    // send reply
//                    DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
//                    outToClient.writreeBytes(capitalizedSentence);

                } // end of while (true)
            } catch (Exception ex) {
                //  ex.printStackTrace();
            }

        }
    }

    public int hashfile(String filename) {
        return Integer.parseInt(filename) % 256;
    }
}
