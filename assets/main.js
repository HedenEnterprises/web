

function el(id)
{
    return document.getElementById(id) || false;
}


function val(id)
{
    return el(id).value || "";
}

window.onload = function()
{
    document.getElementById("contact-me").onclick = function()
    {
        el("thank-you").style.display = "inline-block";

        var xhttp = new XMLHttpRequest();
        xhttp.open("POST", "assets/mail.php", true);
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhttp.send("name=" + val("name") + "&email=" + val("email") + "&details=" + val("project-details"));

        xhttp.onreadystatechange = function() {
            if (this.readyState === 4 || this.status != 200) {
                var error = false;
                if (this.status != 200) {
                    el("thank-you").innerHTML = "Mailing functionality is not working as expected!";
                    error = true;
                }
                else if (this.responseText.includes("error")) {
                    el("thank-you").innerHTML = this.responseText;
                    error = true;
                }

                if (error === true) {
                    el("thank-you").style.color = "#d02e2e";
                    el("thank-you").style.borderColor = "#d02e2e";
                    el("thank-you").style.backgroundColor = "#f8d7da";
                }
            }
        }

        el("name").value = "";
        el("email").value = "";
        el("project-details").value = "";

        setTimeout(function() {
            el("thank-you").style.display = "none";
            el("thank-you").innerHTML = "Thank you! Someone will reach out soon.";
            el("thank-you").style.color = "#0366dd";
            el("thank-you").style.borderColor = "#0366dd";
            el("thank-you").style.backgroundColor = "#dcebfe";
        }, 5000);
    };
};
