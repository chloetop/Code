/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package standard;

import java.security.Security;
import java.util.Date;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Administrator
 */
public class SendEmail {

    private String host = "smtp.gmail.com";
    private String mail_head_name = "this is head of this mail";
    private String mail_head_value = "this is value of this mail";
    private String mail_to = "mailscomp@gmail.com";
    private String mail_from = "mailscomp@gmail.com";
    private String mail_subject = "this is the subject of this test mail";
    private String mail_body = "tttesttestthis is mail_body of this test mail";
    private String personalName = "CSE-Doodle";

    public String getMail_head_name() {
        return mail_head_name;
    }

    public void setMail_head_name(String mail_head_name) {
        this.mail_head_name = mail_head_name;
    }

    public String getMail_head_value() {
        return mail_head_value;
    }

    public void setMail_head_value(String mail_head_value) {
        this.mail_head_value = mail_head_value;
    }

    public String getMail_to() {
        return mail_to;
    }

    public void setMail_to(String mail_to) {
        this.mail_to = mail_to;
    }

    public String getMail_subject() {
        return mail_subject;
    }

    public void setMail_subject(String mail_subject) {
        this.mail_subject = mail_subject;
    }

    public String getMail_body() {
        return mail_body;
    }

    public void setMail_body(String mail_body) {
        this.mail_body = mail_body;
    }

    public void sendMail(String subject, String content, String toMail) {
        setMail_to(toMail);
        setMail_subject(subject);
        setMail_body(content);
        try {
            ////////////////////////version 1 and 2 ok on my own laptop
//            Properties props = new Properties();//��ȡϵͳ����
//            Authenticator auth = new Email_Autherticator();//���
//            //props.put("mail.smtp.port", "465");995
//            props.put("mail.smtp.host", host);
//            props.put("mail.smtp.auth", "true");
//
//            Session session = Session.getDefaultInstance(props, auth);
//            MimeMessage message = new MimeMessage(session);
//            message.setContent("Hello", "text/plain");
//            message.setSubject(mail_subject);
//            message.setText(mail_body);
//            message.setHeader(mail_head_name, mail_head_value);
//            message.setSentDate(new Date());
//            Address address = new InternetAddress(mail_from, personalName);
//            message.setFrom(address);
//            Address toaddress = new InternetAddress(mail_to);
//            message.addRecipient(Message.RecipientType.TO, toaddress);
//            //System.out.println(message);
//            Transport.send(message);
            ///

//            Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
//final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
//  Properties props = System.getProperties();
//    props.setProperty("mail.smtp.host", "smtp.gmail.com");
//    props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
//    props.setProperty("mail.smtp.socketFactory.fallback", "false");
//    props.setProperty("mail.smtp.port", "465");
//    props.setProperty("mail.smtp.socketFactory.port", "465");
//    props.put("mail.smtp.auth", "true");
//    String username="mailscomp";
//    Session session = Session.getDefaultInstance(props, new Authenticator(){
//        protected PasswordAuthentication getPasswordAuthentication() {
//            return new PasswordAuthentication("mailscomp", "!@#123qwe");
//        }});
//    session.setDebug(true);
//    Message msg = new MimeMessage(session);
//
//    // -- Set the FROM and TO fields --
//    msg.setFrom(new InternetAddress(username + "@gmail.com"));
//    msg.setRecipients(Message.RecipientType.TO,
//      InternetAddress.parse("mailscomp@gmail.com",false));
//    msg.setSubject("Hello");
//    msg.setText("How are you");
//    msg.setSentDate(new Date());
//    Transport.send(msg);

            //////////////////////////////////version 3 ok in lab/////////////////////////////////////////
            String to = mail_to;

            // Sender's email ID needs to be mentioned
            String from = "mailscomp@gmail.com";

            // Assuming you are sending email from localhost
            String host = "smtp";

            // Get system properties
            Properties properties = System.getProperties();

            // Setup mail server
            properties.setProperty("mail.smtp.host", host);

            // Get the default Session object.
            Session session = Session.getDefaultInstance(properties);


            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(to));

            // Set Subject: header field
            message.setSubject(mail_subject);

            // Now set the actual message
            message.setText(mail_body);

            // Send message
            Transport.send(message);


        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
