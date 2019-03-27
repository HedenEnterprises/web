<?php
require_once("PHPMailer-6.0.7/src/PHPMailer.php");
require_once("PHPMailer-6.0.7/src/SMTP.php");
require_once("PHPMailer-6.0.7/src/Exception.php");
use PHPMailer\PHPMailer\PHPMailer;


exit(0);
/* todo: inject these values as a kubernetes secret */
define("guser", "");
define("gpass", "");

define("grcpt", "");
define("gname", "");


function heden_mail($to, $from, $from_name, $subject, $body)
{ 
    global $error;
    $mail = new PHPMailer();
    $mail->IsSMTP();
    $mail->SMTPDebug = 0;
    $mail->SMTPAuth = true;
    $mail->SMTPSecure = 'ssl';
    $mail->Host = 'smtp.gmail.com';
    $mail->Port = 465;
    $mail->Username = guser;
    $mail->Password = gpass;
    $mail->SetFrom($from, $from_name);
    $mail->Subject = $subject;
    $mail->Body = $body;
    $mail->AddAddress($to);

    if(!$mail->Send()) {
        heden_log("Mail error: " . $mail->ErrorInfo);
    } else {
        echo "Message sent!";
    }
}

handle_request();

function handle_request()
{
    $name = "";
    $email = "";
    $details = "";

    if (isset($_POST["name"])) {
        echo "Got name";
        $name = $_POST["name"];
    }
    if (isset($_POST["email"])) {
        echo "Got email";
        $email = $_POST["email"];
    }
    if (isset($_POST["details"])) {
        echo "Got details";
        $details = $_POST["details"];
    }

    if (isset($_GET["name"])) {
        echo "Got name";
        $name = $_GET["name"];
    }
    if (isset($_GET["email"])) {
        echo "Got email";
        $email = $_GET["email"];
    }
    if (isset($_GET["details"])) {
        echo "Got details";
        $details = $_GET["details"];
    }

    if (empty($name) || empty($email) || empty($details)) {
        heden_log("Must supply name,email,details");
        exit(0);
    } else if (strpos($email, "@") === false) {
        heden_log("Email must be valid");
        exit(0);
    }

    $name = preg_replace('/[^A-Za-z0-9]/', ' ', $name);
    $details = preg_replace('/[^A-Za-z0-9\n]/', ' ', $details);

    heden_log("name [<pre>$name</pre>]<br>");
    heden_log("email [<pre>$email</pre>]<br>");
    heden_log("details [<pre>$details</pre>]<br>");

    $subject = "Contact from $name : " . date("r");

    heden_mail(grcpt, guser, gname, $subject, $details);
}


function heden_log($msg)
{
    file_put_contents("heden_log", $msg . "\n", FILE_APPEND);
    $msg .= "\n";
    $msg = nl2br($msg);
    echo $msg;
}
