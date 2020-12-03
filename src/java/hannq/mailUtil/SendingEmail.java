package hannq.mailUtil;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Han Quang
 */
public class SendingEmail {
    String HOST_NAME = "smtp.gmail.com";
    int TLS_PORT = 587;
    String APP_EMAIL = "emailforlabweb@gmail.com";
    String APP_PASSWORD = "ckedolemrmpzzrkm";
    
    public int sendEmail(String memberID){
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", HOST_NAME);
        props.put("mail.smtp.port",TLS_PORT);
        props.put("mail.smtp.starttls.enable", "true");
        // get Session
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });
        // compose message
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(APP_EMAIL)); 
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(memberID));
            message.setSubject("MiniSocialNetwork Verification Code");
            int randomNum = (int)(Math.random() * ((999999 - 100000) + 1)) + 100000;
            message.setText("Your verification code is " + randomNum);
            // send message
            Transport.send(message);
            return randomNum;
        } catch (Exception e) {
            return 0;
        } 
    }
}
