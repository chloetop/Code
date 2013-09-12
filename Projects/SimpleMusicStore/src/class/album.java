/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

/**
 *
 * @author Administrator
 */
public class album {

    private String album_id;
    private String Artist;
    private String Title;
    private String Genre;
    private String Year;
    private String Publisher;
    private String Price;
    private String Description;

    public void album() {
        album_id = null;
        Artist = null;
        Title = null;
        Genre = null;
        Year = null;
        Publisher = null;
        Price = null;
        Description = null;

    }

    /**
     * @return the album_id
     */
    public String getAlbum_id() {
        return album_id;
    }

    /**
     * @param album_id the album_id to set
     */
    public void setAlbum_id(String album_id) {
        this.album_id = album_id;
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
     * @return the Title
     */
    public String getTitle() {
        return Title;
    }

    /**
     * @param Title the Title to set
     */
    public void setTitle(String Title) {
        this.Title = Title;
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
     * @return the Publisher
     */
    public String getPublisher() {
        return Publisher;
    }

    /**
     * @param Publisher the Publisher to set
     */
    public void setPublisher(String Publisher) {
        this.Publisher = Publisher;
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
     * @return the Description
     */
    public String getDescription() {
        return Description;
    }

    /**
     * @param Description the Description to set
     */
    public void setDescription(String Description) {
        this.Description = Description;
    }
}
