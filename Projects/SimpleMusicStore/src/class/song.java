/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

/**
 *
 * @author Administrator
 */
public class song {

    private String song_id;
    private String song_name;
    private String in_album;
    private String Price;
    private String Artist;
    private String Genre;
    private String Year;
    private String album;
private String Publisher;
    public void album() {
        song_id = null;
        song_name = null;
        in_album = null;
        Price = null;
        Artist = null;
        Genre = null;
        Year = null;
        album = null;
        Publisher = null;

    }

    /**
     * @return the song_id
     */
    public String getSong_id() {
        return song_id;
    }

    /**
     * @param song_id the song_id to set
     */
    public void setSong_id(String song_id) {
        this.song_id = song_id;
    }

    /**
     * @return the song_name
     */
    public String getSong_name() {
        return song_name;
    }

    /**
     * @param song_name the song_name to set
     */
    public void setSong_name(String song_name) {
        this.song_name = song_name;
    }

    /**
     * @return the in_album
     */
    public String getIn_album() {
        return in_album;
    }

    /**
     * @param in_album the in_album to set
     */
    public void setIn_album(String in_album) {
        this.in_album = in_album;
    }

    /**
     * @return the Price
     */
    public String getPrice() {
        return Price;
    }

    /**
     * @param Price the Price to set
     */
    public void setPrice(String Price) {
        this.Price = Price;
    }

    /**
     * @return the Artist
     */
    public String getArtist() {
        return Artist;
    }

    /**
     * @param Artist the Artist to set
     */
    public void setArtist(String Artist) {
        this.Artist = Artist;
    }

    /**
     * @return the Genre
     */
    public String getGenre() {
        return Genre;
    }

    /**
     * @param Genre the Genre to set
     */
    public void setGenre(String Genre) {
        this.Genre = Genre;
    }

    /**
     * @return the Year
     */
    public String getYear() {
        return Year;
    }

    /**
     * @param Year the Year to set
     */
    public void setYear(String Year) {
        this.Year = Year;
    }

    /**
     * @return the album
     */
    public String getAlbum() {
        return album;
    }

    /**
     * @param album the album to set
     */
    public void setAlbum(String album) {
        this.album = album;
    }
    
      /**
     * @return the Publisher
     */
    public String getPublisher() {
        return Publisher;
    }

    /**
     * @param album the album to set
     */
    public void setPublisher(String Publisher) {
        this.Publisher = Publisher;
    }
}
