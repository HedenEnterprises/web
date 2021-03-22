<?php
require_once("PHPMailer-6.0.7/src/PHPMailer.php");
require_once("PHPMailer-6.0.7/src/SMTP.php");
require_once("PHPMailer-6.0.7/src/Exception.php");
use PHPMailer\PHPMailer\PHPMailer;


require_once("sensitive.php");

if (empty($mail_recipient) || empty($mail_recipient_name)) {
    echo "sensitive.php missing \$mail_recipient and/or \$mail_recipient_name";
    exit(0);
}

if (empty($aws_smtp_user_name) || empty($aws_smtp_password)) {
    echo "sensitive.php missing \$aws_smtp_user_name and/or \$aws_smtp_password";
    exit(0);
}

if (empty($aws_smtp_server) || empty($aws_smtp_port) || empty($aws_smtp_use_tls)) {
    echo "sensitive.php missing \$aws_smtp_server and/or \$aws_smtp_port and/or \$aws_smtp_use_tls";
    exit(0);
}


function handle_request()
{
    global $mail_recipient;
    global $mail_recipient_name;
    global $aws_smtp_user_name;
    global $aws_smtp_password;
    global $aws_smtp_server;
    global $aws_smtp_port;
    global $aws_smtp_use_tls;

    $name = "";
    $email = "";
    $details = "";

    if (isset($_POST["name"])) {
        $name = $_POST["name"];
    }
    if (isset($_POST["email"])) {
        $email = $_POST["email"];
    }
    if (isset($_POST["details"])) {
        $details = $_POST["details"];
    }

    if (empty($name) || empty($email) || empty($details)) {
        echo "Must supply name and/or email and/or details";
        exit(0);
    } else if (strpos($email, "@") === false) {
        echo "Email address must be valid";
        exit(0);
    }

    $subject = "Contact from $name : " . date("r");
    $body    = date("r") . "\r\nFrom: $name\r\nEmail: $email\r\n\r\n" . $details;

    $mail = new PHPMailer();

    $mail->IsSMTP();

    $mail->SMTPDebug  = 0;
    $mail->SMTPAuth   = true;
    $mail->SMTPSecure = ($aws_smtp_use_tls == true ? "tls" : "ssl");
    $mail->Host       = $aws_smtp_server;
    $mail->Port       = $aws_smtp_port;
    $mail->Username   = $aws_smtp_user_name;
    $mail->Password   = $aws_smtp_password;
    $mail->Subject    = $subject;
    $mail->Body       = $body;

    $mail->SetFrom($mail_recipient, $mail_recipient_name);
    $mail->AddAddress($mail_recipient);

    if(!$mail->Send()) {
        echo "Mail error: " . $mail->ErrorInfo;
    } else {
        echo "Message sent!";
    }
}


handle_request();
