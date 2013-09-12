package PublicClass;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Email_Autherticator extends Authenticator {
	String username = "mailscomp";
	
	String password = "!@#123qwe";
	public Email_Autherticator() {
		super();
	}
	public Email_Autherticator(String user,String pwd){
		super();
		username = user;
		password = pwd;
	}
	public PasswordAuthentication getPasswordAuthentication(){
		return new PasswordAuthentication(username,password);
	}
}
