package service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {
  private final Session session;
  private final String from;

  public EmailService() {
    // Read SMTP config from environment; fallback to no-auth localhost if not set
    String host = getenvOr("SMTP_HOST", "localhost");
    String port = getenvOr("SMTP_PORT", "25");
    String user = getenvOr("SMTP_USERNAME", "");
    String pass = getenvOr("SMTP_PASSWORD", "");
    this.from = getenvOr("SMTP_FROM", "noreply@moffatbay.local");

    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", port);
    props.put("mail.smtp.auth", user.isEmpty() ? "false" : "true");
    props.put("mail.smtp.starttls.enable", getenvOr("SMTP_STARTTLS", "true"));

    if (!user.isEmpty()) {
      this.session = Session.getInstance(props, new Authenticator() {
        @Override protected PasswordAuthentication getPasswordAuthentication() {
          return new PasswordAuthentication(user, pass);
        }
      });
    } else {
      this.session = Session.getInstance(props);
    }
  }

  public void send(String to, String subject, String body) throws MessagingException {
    if (to == null || to.isBlank()) return; // nothing to do
    MimeMessage msg = new MimeMessage(session);
    msg.setFrom(new InternetAddress(from));
    msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
    msg.setSubject(subject, "UTF-8");
    msg.setText(body, "UTF-8");
    Transport.send(msg);
  }

  private static String getenvOr(String key, String def) {
    String v = System.getenv(key);
    return v == null || v.isBlank() ? def : v;
  }
}
