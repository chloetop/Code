/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 *
 * @author Administrator
 */
public class Search {

    public album SearchAlbum(String id, NodeList nl) {
        album al = new album();
        int len = nl.getLength();
        for (int i = 0; i < len; i++) {
            Node nNode = nl.item(i);
            String temp;
            Element eElement = (Element) nNode;

            temp = eElement.getElementsByTagName("album_id").item(0).getChildNodes().item(0).getNodeValue();
            if (temp.equals(id)) {
                al.setAlbum_id(temp);
                temp = eElement.getElementsByTagName("Artist").item(0).getChildNodes().item(0).getNodeValue();
                al.setArtist(temp);
                temp = eElement.getElementsByTagName("Title").item(0).getChildNodes().item(0).getNodeValue();
                al.setTitle(temp);
                temp = eElement.getElementsByTagName("Genre").item(0).getChildNodes().item(0).getNodeValue();
                al.setGenre(temp);
                temp = eElement.getElementsByTagName("Year").item(0).getChildNodes().item(0).getNodeValue();
                al.setYear(temp);
                temp = eElement.getElementsByTagName("Publisher").item(0).getChildNodes().item(0).getNodeValue();
                al.setPublisher(temp);
                temp = eElement.getElementsByTagName("Price").item(0).getChildNodes().item(0).getNodeValue();
                al.setPrice(temp);
                temp = eElement.getElementsByTagName("Description").item(0).getChildNodes().item(0).getNodeValue();
                al.setDescription(temp);
            }
        }
        return al;
    }

    public album SearchPrice(String id, NodeList nl) {
        album al = new album();
        int len = nl.getLength();
        for (int i = 0; i < len; i++) {
            Node nNode = nl.item(i);
            String temp;
            Element eElement = (Element) nNode;

            temp = eElement.getElementsByTagName("album_id").item(0).getChildNodes().item(0).getNodeValue();
            if (temp.equals(id)) {
                al.setAlbum_id(temp);
                temp = eElement.getElementsByTagName("Artist").item(0).getChildNodes().item(0).getNodeValue();
                al.setArtist(temp);
                temp = eElement.getElementsByTagName("Title").item(0).getChildNodes().item(0).getNodeValue();
                al.setTitle(temp);
                temp = eElement.getElementsByTagName("Genre").item(0).getChildNodes().item(0).getNodeValue();
                al.setGenre(temp);
                temp = eElement.getElementsByTagName("Year").item(0).getChildNodes().item(0).getNodeValue();
                al.setYear(temp);
                temp = eElement.getElementsByTagName("Publisher").item(0).getChildNodes().item(0).getNodeValue();
                al.setPublisher(temp);
                temp = eElement.getElementsByTagName("Price").item(0).getChildNodes().item(0).getNodeValue();
                al.setPrice(temp);
                temp = eElement.getElementsByTagName("Description").item(0).getChildNodes().item(0).getNodeValue();
                al.setDescription(temp);

            }
        }
        return al;
    }

    public song SearchPrice2(String id, NodeList nl) {
        song sg = new song();
        int len = nl.getLength();
        for (int i = 0; i < len; i++) {
            Node nNode = nl.item(i);
            String temp;
            Element eElement = (Element) nNode;

            temp = eElement.getElementsByTagName("song_id").item(0).getChildNodes().item(0).getNodeValue();
            if (temp.equals(id)) {
                sg.setSong_id(temp);
                temp = eElement.getElementsByTagName("song_name").item(0).getChildNodes().item(0).getNodeValue();
                sg.setSong_name(temp);
                temp = eElement.getElementsByTagName("in_album").item(0).getChildNodes().item(0).getNodeValue();
                sg.setIn_album(temp);
                temp = eElement.getElementsByTagName("Price").item(0).getChildNodes().item(0).getNodeValue();
                sg.setPrice(temp);
            }
        }
        return sg;
    }
    //public song SearchSong()
}
