

function el(id)
{
    return document.getElementById(id) || false;
}


function val(id)
{
    return el(id).value || "";
}


document.getElementById("contact-me").onclick = function()
{
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "assets/mail", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("name=" + val("name") + "&email=" + val("email") + "&details=" + val("project-details"));

    el("thank-you").style.display = "inline-block";
    setTimeout(function() { el("thank-you").style.display = "none"; }, 5000);
};
