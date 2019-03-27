<?php

if (empty($page_title)) {
    $page_title = "Heden Enterprises";
}

if (empty($meta_description)) {
    $meta_description = "Heden Enterprises is dedicated to providing the highest quality service to a range of consulting services.";
}

if (empty($google_analytics_id)) {
    $google_analytics_id = "UA-136328258-1";
}

if (empty($optional_head_tags)) {
    $optional_head_tags = "";
}

?>

<!doctype html>

<html lang="en-US">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
    <meta name="description" content="<?php echo $meta_description; ?>" />

    <link rel="stylesheet" type="text/css" href="assets/style.css" />
    <link async rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:400,500,600,700,900" />
    <link rel="stylesheet" type="text/css" href="assets/fontawesome/css/all.css" />
    <link rel="stylesheet" type="text/css" href="assets/fontawesome/css/v4-shims.css" />

    <?php echo $optional_head_tags; ?>

    <title><?php echo $page_title; ?></title>

    <script async src="https://www.googletagmanager.com/gtag/js?id=<?php echo $google_analytics_id; ?>"></script>
    <script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag("js",new Date());gtag("config","<?php echo $google_analytics_id; ?>");</script>

</head>

<body>

    <header class="header" role="header">
        <div class="container">
            <nav class="nav" role="navigation">
                <div class="logo">
                    <a href="https://hedenenterprises.io/">Heden Enterprises</a>
                </div>
                <div class="nav-items">
                    <ul>
                        <li>
                            <a href="/services">Services</a>
                            <ul>
                                <li><a href="/services#development">Development</a></li>
                                <li><a href="/services#data-science">Data Science</a></li>
                                <li><a href="/services#cloud-services">Cloud Services</a></li>
                                <li><a href="/services#network-monitoring">Network Monitoring</a></li>
                                <li><a href="/services#security">Security</a></li>
                                <li><a href="/services#managed-services">Managed Services</a></li>
                                <li><a href="/services#automation">Automation</a></li>
                                <li><a href="/services#training">Training</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="https://blog.hedenenterprises.io/">Blog</a>
                        </li>
                        <li>
                            <a href="/#contact">Contact</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </header>
