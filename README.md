# web

> Heden Enterprises website as code.

This is the most basic of a templating system.

[![Build Status](https://travis-ci.org/HedenEnterprises/web.svg?branch=main)](https://travis-ci.org/HedenEnterprises/web)

## How do I?

You *really* want to use this? Go for it.

All you need to do is clone the repository, and then create a file `sensitive.php` in `assets/`. That file should contain these variables:

``` php
<?php

// this is optional
$google_analytics_tracking_id = "UA-XXXXXXXXX-X";

// who is receiving the message
$mail_recipient      = "";
$mail_recipient_name = "";

// settings from aws ses (go through domain validation and then add $mail_recipient as a verified email recipient)
$aws_smtp_user_name = ""; // these credentials will be shown when setting up smtp credentials
$aws_smtp_password  = "";

$aws_smtp_server  = "email-smtp.us-east-2.amazonaws.com"; // check your settings for proper hostname
$aws_smtp_port    = 587;
$aws_smtp_use_tls = true;

?>
```

Then obviously update the `templates/` files and `assets/style.css` accordingly with your code.

Now you're ready to create content. To get rid of my main content, in the root directory you can do an `rm *.php` and then create your own `index.php`:

``` php
<?php

$page_title = "Heden Enterprises";
$meta_description = "Heden Enterprises is your technology consultant in the twin cities";

require("template/header.php");
?>
```

After that block, add your content. Once you're done with your content, you can append the footer:

``` php

<?php

require("template/footer.php");

```

That should be it.
