/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;

/**
 *
 * @author Administrator
 */
public class MANETEXofOSPF {

    /**
     * @param args the command line arguments
     */
    static List<String> sgm = new ArrayList<String>(); // nodes coordinates
    static double[][] DisMetric;  // distance between any two nodes
    static int[][] CloseMetric;   // say a node, sort other nodes from closest to farest
    static String[][] Vec;        // node's coordinates
    static int[][] dn;   // -1----no link    other wise-----index of current point
    static int[] mdr;    // mdr set, 1----is mdr    0-----not
    static double range = 0;   // wireless range
    static int unit = 50;      // coordinate's unit
    static int[] p;    // mdr set, 1----is mdr    0-----not
    static int[] r;    // mdr set, 1----is mdr    0-----not

    public static void main(String[] args) {
        // TODO code application logic here
        if (args.length < 1) {
            System.out.println("require a file name");
            return;
        }
        String filename = args[0];

        int MDRConstraint = 3;
        double width = 0;  // Pic width
        double height = 0; // Pic height
        // get input from a file
        try {
            String thisLine;
            FileInputStream fin = new FileInputStream(filename);
            DataInputStream myInput = new DataInputStream(fin);
            while ((thisLine = myInput.readLine()) != null) {  // while loop begins here
                System.out.println(thisLine + "-----" + thisLine.length());
                sgm.add(thisLine);
                //File_Content += thisLine+"\n";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        // record a node's X and Y, measure size of further Pic
        Vec = new String[sgm.size()][3];
        for (int i = 0; i < sgm.size(); i++) {
            Vec[i][0] = sgm.get(i).split("	")[0];
            Vec[i][1] = sgm.get(i).split("	")[1];
            Vec[i][2] = sgm.get(i).split("	")[2];

            if (width == 0) {
                width = Double.parseDouble(Vec[i][1]);
            } else {
                if (width < Double.parseDouble(Vec[i][1])) {
                    width = Double.parseDouble(Vec[i][1]);
                }
            }
            if (height == 0) {
                height = Double.parseDouble(Vec[i][2]);
            } else {
                if (height < Double.parseDouble(Vec[i][2])) {
                    height = Double.parseDouble(Vec[i][2]);
                }
            }
        }
        range = Double.parseDouble(Vec[0][0]);// set wireless range
        //conver further Pic in unit
        int lenght = 0;
        while (true) {
            if (unit * lenght > width) {
                width = unit * lenght;
                break;
            }
            lenght++;
        }
        lenght = 0;
        while (true) {
            if (unit * lenght > height) {
                height = unit * lenght;
                break;
            }
            lenght++;
        }
        // compute distance between nodes
        DisMetric = new double[sgm.size()][sgm.size()];
        DecimalFormat df2 = new DecimalFormat("###.00");
        for (int i = 1; i < sgm.size(); i++) {
            for (int j = 1; j < sgm.size(); j++) {
                DisMetric[i][j] = Math.pow(Math.pow(Double.parseDouble(Vec[i][1]) - Double.parseDouble(Vec[j][1]), 2) + Math.pow(Double.parseDouble(Vec[i][2]) - Double.parseDouble(Vec[j][2]), 2), 0.5);
                //   System.out.print(fill(df2.format(DisMetric[i][j]),7,' ') + "-");
            }
            //   System.out.println("");
        }
//        for (int i = 0; i < sgm.size(); i++) {
//            for (int j = 0; j < sgm.size(); j++) {
//                if (i == 0 || j == 0) {
//                    if (i == 0 && j == 0) {
//                        System.out.print(fill("0", 7, ' ') + "-");
//                    } else {
//                        if (i == 0) {
//                            System.out.print(fill(String.valueOf(j), 7, ' ') + "-");
//                        }
//                        if (j == 0) {
//                            System.out.print(fill(String.valueOf(i), 7, ' ') + "-");
//                        }
//                    }
//                } else {
//                    System.out.print(fill(df2.format(DisMetric[i][j]), 7, ' ') + "-");
//                }
//            }
//            System.out.println("");
//        }
        // a node's sorting nodes set, from the closest to the farest
        CloseMetric = new int[sgm.size()][sgm.size()];
        for (int i = 1; i < sgm.size(); i++) {
            double[] temp = new double[sgm.size()];
            for (int j = 1; j < sgm.size(); j++) {
                temp[j] = DisMetric[i][j];
            }
            for (int j = 1; j < sgm.size(); j++) {
                int k = j;
                double tag;
                for (int m = j + 1; m < sgm.size(); m++) {
                    if (temp[m] < temp[k]) {
                        k = m;
                    }
                }
                if (k != j) {
                    tag = temp[k];
                    temp[k] = temp[j];
                    temp[j] = tag;
                }
            }
            for (int j = 1; j < sgm.size(); j++) {
                for (int n = 1; n < sgm.size(); n++) {
                    if (temp[j] == DisMetric[i][n]) {
                        CloseMetric[i][j] = n;
                    }
                }
            }
        }
        // compute cost metric
        int[][] c = new int[sgm.size()][sgm.size()];
        for (int i = 1; i < sgm.size(); i++) {
            for (int j = 1; j < sgm.size(); j++) {
                if (DisMetric[i][CloseMetric[i][j]] <= range) {
//                    System.out.print(fill(String.valueOf(CloseMetric[i][j]), 2, ' ') + "--");
                    c[i][j] = 1;
                } else {
//                    System.out.print(fill("", 2, ' ') + "--");
                    c[i][j] = 0;
                }
            }
        //    System.out.println("");
        }
        //initialise dn-depandent neighbor, mdr
        dn = new int[sgm.size()][sgm.size()];  // -1----no link    other wise-----index of current point
        mdr = new int[sgm.size()]; // 1----mdr;   0 ----not mdr
        for (int i = 0; i < sgm.size(); i++) {
            for (int j = 0; j < sgm.size(); j++) {
                dn[i][j] = -1;
            }
            mdr[i] = 0;
        }
        p = new int[sgm.size()];
        for (int i = 0; i < sgm.size(); i++) {
            p[i] = 0;
        }

        // start to find mdr
        int n = 0;
        int tag = -1;
        while (tag != NumOfMDR()) {
            tag = NumOfMDR();// if mdr level changes, loop continues till no changes
            //make set of dependent neighbors empty
            for (int i = 1; i < sgm.size(); i++) {
                for (int j = 1; j < sgm.size(); j++) {
                    dn[i][j] = -1;
                }
            }
            // int dex = 30;
            for (int dex = 1; dex < sgm.size(); dex++) {
                int[] arr = getbi_neighbors(dex);
                int Rmax = Return_Largest_Bi_neighbors(arr, dex);
                if (Rmax < dex) {
                    Rmax = dex;
                    mdr[dex] = 1;
                    for (int j = 0; j < arr.length; j++) {
                        if (mdr[arr[j]] == 1) {
                            dn[dex][arr[j]] = 1;
                        }
                    }

                    if (p[dex] < dex) {
                        p[dex] = dex;
                    }
                }
                int[] hops = BFS(arr, dex, Rmax); //  -1-------infinity
                int t = 1;
                for (int i = 0; i < arr.length; i++) {
                    if (hops[i] > MDRConstraint || hops[i] == -1) {
                        t = 0;
                        break;
                    }
                }
                if (t == 1) // <= 3
                {
                } else {
                    mdr[dex] = 1;
                    if (mdr[Rmax] == 1) {// if Rmax is mdr, ser Rmax as current node's dependent neighbor
                        if (dex != Rmax) {
                            dn[dex][Rmax] = 1;
                        }
                    }
                    for (int i = 0; i < arr.length; i++) {// set bi-neighbors who are mdr and hop > MDRConstraint as dependendt neighbors
                        if (dex == arr[i]) {
                            continue;
                        }
                        if (mdr[arr[i]] == 1 && (hops[i] == -1 || hops[i] > MDRConstraint)) {
                            dn[dex][arr[i]] = 1;
                        }
                    }
                }
            }
        }
        //flood mdr...
//        r = new int[sgm.size()];
//        for (int i = 0; i < sgm.size(); i++) {
//            r[i] = 0;
//        }
//        r[Integer.parseInt(Vec[sgm.size() - 1][0])] = Integer.parseInt(Vec[sgm.size() - 1][0]);
//        floodmdr(Integer.parseInt(Vec[sgm.size() - 1][0]), Integer.parseInt(Vec[sgm.size() - 1][0]),Integer.parseInt(Vec[sgm.size() - 1][0]));
//        // set dependent neighbors of a node which is not a mdr
        for (int i = 1; i < sgm.size(); i++) {
            if (mdr[i] == 0) {
                int[] x = getbi_neighbors(i);
                for (int j = 0; j < x.length; j++) {
                    if (mdr[x[j]] == 1) {
                        dn[i][x[j]] = 1;
                        break;
                    }
                }
            }
        }
        System.out.println("-------------------start-----------------");
        System.out.println("index followed by that if it is a MDR, 1 is a MDR, 0 is not a MDR");
        for (int i = 1; i < sgm.size(); i++) {
            System.out.print(fill(String.valueOf(i), 2, ' ') + "--");
        }
        System.out.println();
        for (int i = 1; i < sgm.size(); i++) {
            System.out.print(fill(String.valueOf(mdr[i]), 2, ' ') + "--");
        }
        System.out.println();
//        for (int i = 1; i < sgm.size(); i++) {
//            System.out.print(fill(String.valueOf(p[i]), 2, ' ') + "--");
//        }
//        System.out.println();
          System.out.println("Adjacent Node IDs:");
        for (int i = 1; i < sgm.size(); i++) {
            System.out.print(i + ":");
            for (int j = 1; j < sgm.size(); j++) {
                if (dn[i][j] == 1 || dn[j][i] == 1) // System.out.print(fill(String.valueOf(dn[i][j]), 2, ' ') + "__");
                {
                    System.out.print(fill(String.valueOf(j), 2, ' ') + "__");
                }
            }
            System.out.println();
        }
        // output a pic of graph
        OutToJPG((int) width, (int) height, unit);

    }
    //input: width- width of pic;  height- height of pic;  unit- coordinate unit
    //output; pic file

    public static void floodmdr(int node, int max, int from) {
        if (r[node] == 0) {
            r[node] = 1;
        }
        if (p[node] != max) {
            int tag = p[node];
            p[node] = max;
            //   dn[node][from] = 1;

        }
        int[] arr = getbi_neighbors(node);
        for (int i = 0; i < arr.length; i++) {
            if (mdr[arr[i]] == 1 && r[arr[i]] == 0) {
                floodmdr(arr[i], max, node);
            }
        }


    }

    public static void OutToJPG(int width, int height, int unit) {
        try {

            // TYPE_INT_ARGB specifies the image format: 8-bit RGBA packed
            // into integer pixels
            BufferedImage bi = new BufferedImage(width + 100, height + 100, BufferedImage.TYPE_INT_RGB);
            Graphics2D g2d = (Graphics2D) bi.createGraphics();

            // g2d.setBackground(Color.WHITE);// set background color
            g2d.setColor(Color.WHITE);
            g2d.fillRect(0, 0, width + 100, height + 100);
//            g2d.setPaint(Color.white);
//            for (int i = 0; i <= height + 100; i++) {
//                g2d.drawLine(0, i, 100 + width, i); // draw Y
//            }
            g2d.setPaint(Color.black);     // set pen color

            g2d.setStroke(new BasicStroke(2)); // set thickness of pen
            Font font = new Font("TimesRoman", Font.BOLD, 15); // set font style
            g2d.setFont(font);
            g2d.drawLine(unit, unit + height, unit + width, unit + height); // draw Y
            g2d.drawLine(unit, unit, unit, unit + height); // draw X
            int length = 0;
            while (true) { // draw X coordinates
                g2d.drawLine(unit + unit * length, unit + height, unit + unit * length, unit + height - 10);
                g2d.drawString(String.valueOf(unit * length), unit + unit * length - 10, unit + height + 20);
                if (length * unit == width) {
                    break;
                }
                length++;
            }
            length = 0;
            while (true) { //draw Y coordinates
                g2d.drawLine(unit, unit + unit * length, unit + 10, unit + unit * length); // draw Y
                g2d.drawString(String.valueOf(height - unit * length), unit - 25, unit + unit * length + 5);
                if (length * unit == height) {
                    break;
                }
                length++;
            }
            //draw title
            g2d.drawString("MANETs nodes--Transmission Range= "+ range, 120, 15);
            g2d.drawString(" nodes with double circles(Red circle) are MDRs", 60, 30);
            //draw nodes
            for (int i = 1; i < mdr.length; i++) {
                g2d.drawOval(unit + (int) Double.parseDouble(Vec[i][1]), unit + height - (int) Double.parseDouble(Vec[i][2]), 6, 6);
                if (mdr[i] == 1) {
                    g2d.setPaint(Color.red);
                    g2d.drawOval(unit + (int) Double.parseDouble(Vec[i][1]) - 3, unit + height - (int) Double.parseDouble(Vec[i][2]) - 3, 12, 12);
                    g2d.setPaint(Color.black);
                }

                g2d.drawString(String.valueOf(i), unit + (int) Double.parseDouble(Vec[i][1]) - 5, unit + height - (int) Double.parseDouble(Vec[i][2]) - 5);
            }
            //draw lines
            g2d.setPaint(Color.blue);
            for (int i = 1; i < mdr.length; i++) {
                if (mdr[i] == 1) {
                    g2d.setStroke(new BasicStroke(3)); // thickness of pen
                } else {
                    g2d.setStroke(new BasicStroke(1)); // thickness of pen
                }
                for (int j = 1; j < dn[i].length; j++) {
//                    if (mdr[i] != 1) {
                    if (dn[i][j] == 1) {
                        g2d.drawLine(unit + (int) Double.parseDouble(Vec[i][1]) + 3, unit + height - (int) Double.parseDouble(Vec[i][2]) + 3, unit + (int) Double.parseDouble(Vec[j][1]) + 3, unit + height - (int) Double.parseDouble(Vec[j][2]) + 3);
                    }
//                    } else {
//                        if (dn[i][j] == 1&& dn[j][i]==1) {
//                            g2d.drawLine(unit + (int) Double.parseDouble(Vec[i][1]) + 3, unit + height - (int) Double.parseDouble(Vec[i][2]) + 3, unit + (int) Double.parseDouble(Vec[j][1]) + 3, unit + height - (int) Double.parseDouble(Vec[j][2]) + 3);
//                        }
//                      
//                    }
                }
            }
            //  ImageIO.write(bi, "gif", new File("pic.jpg"));
            ImageIO.write(bi, "jpg", new File("pic.JPG"));
        } catch (IOException ex) {
            Logger.getLogger(MANETEXofOSPF.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    //compute hop value of each neighbors of i from Rmax to this neighbor

    public static int[] BFS(int arr[], int index, int max) {
        int[] hops = new int[arr.length];
        int[] mirror = new int[31];

        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == max) {
                hops[i] = 0;
            } else {
                hops[i] = -1;
            }
            mirror[arr[i]] = i;
        }
        List<Integer> queue = new ArrayList<Integer>();
        queue.add(max);
        while (!queue.isEmpty()) {
            int u = queue.get(0);
            queue.remove(0);
            for (int i = 0; i < arr.length; i++) {
                if (u == arr[i]) {
                    continue;
                }
                int v = arr[i];
                if (DisMetric[u][v] < range) {
                    if (u > index) {
                        if (hops[mirror[v]] == -1 || hops[mirror[v]] > hops[mirror[u]] + 1) {
                            hops[mirror[v]] = hops[mirror[u]] + 1;
                            queue.add(v);
                            if (p[v] < max) {
                                p[v] = max;
                            }
                        }
                    }
                }
            }
        }
        return hops;
    }
// return largest neighbors to check if itself is the largest one

    public static int Return_Largest_Bi_neighbors(int arr[], int index) {// step 2.2
        int max = 0;
        for (int i = 0; i < arr.length; i++) {
            if (max == 0) {
                max = arr[i];
            }
            if (max < arr[i]) {
                max = arr[i];
            }
        }
        return max;
    }
    // return current size of mdr, to see if it changes in before and after

    public static int NumOfMDR() {
        int n = 0;
        for (int i = 0; i < mdr.length; i++) {
            if (mdr[i] == 1) {
                n++;
            }
        }
        return n;
    }
    // return set of neighbors

    public static int[] getbi_neighbors(int index) {
        int size = 0;
        for (int j = 2; j < sgm.size(); j++) {
            if (DisMetric[index][CloseMetric[index][j]] <= range) {
                // System.out.print(fill(String.valueOf(CloseMetric[index][j]), 2, ' ') + "--");
                size++;
            }
        }
        int[] arr = new int[size];
        size = 0;
        for (int j = 2; j < sgm.size(); j++) {
            if (DisMetric[index][CloseMetric[index][j]] <= range) {
                //  System.out.print(fill(String.valueOf(CloseMetric[index][j]), 2, ' ') + "--");
                arr[size] = CloseMetric[index][j];
                size++;
            }
        }
        return arr;
    }
    //format output content

    private static String fill(String input, int size, char symbol) {
        while (input.length() < size) {
            input = symbol + input;
        }
        return input;
    }
}
