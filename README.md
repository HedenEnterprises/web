# web

> Heden Enterprises website as code.

This is the most basic of a templating system.

## How do I?

You *really* want to use this? Go for it.

All you need to do is clone the repository, and then create a file `sensitive.php` in `assets/`. That file should contain these variables:

``` php
<?php

// this is optional
$google_analytics_tracking_id = "UA-XXXXXXXXX-X";

// who is authenticating against gmail
$gmail_user = "";
$gmail_password = "";

// who is receiving the message
$mail_recipient = "";
$mail_recipient_name = "";

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
