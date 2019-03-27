<?php


function print_help()
{
    global $argv;

    fwrite(STDERR, "\n  Usage:\n\n");
    fwrite(STDERR, "    ${argv[0]} --header=/path/to/header.php --footer=/same/footer.php --content=../file.php > file.html\n\n");

    exit(1);
}


function build()
{
    $long_opts = array(
        "help",
        "header:",
        "footer:",
        "content:",
    );

    $opts = getopt("", array("help", "header:", "content:", "footer:"));

    if (!empty($opts["help"])) {
        print_help();
    }

    if (empty($opts["header"]) || empty($opts["footer"]) || empty($opts["content"])) {
        print_help();
    }

    $header = $opts["header"];
    $footer = $opts["footer"];
    $content = $opts["content"];

    /* capture output from content while having the specified variables set for us */
    ob_start();
    require_once($content);
    $content = ob_get_clean();

    require_once($header);
    echo $content;
    require_once($footer);
}
