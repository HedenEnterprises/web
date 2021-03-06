<?php

$page_title = "Heden Enterprises";
$meta_description = "Heden Enterprises is your technology consultant in the twin cities";

$banner_html = '
    <section class="above-the-fold">
        <div class="container">
            <h1>Anticipate. Adapt.</h1>
            <h1>Accelerate.</h1>
            <a href="/#contact" class="button">Get Started</a>
        </div>
    </section>
';

require("template/header.php");
?>


<main>
    <section class="services">

        <div class="section-title">
            <h3>Services</h3>
            <span></span>
        </div>

        <div class="container">

            <div class="service shadow">
                <i class="fa fa-code"></i>
                <span class="what">Development</span>
                <span class="why">Deliver results</span>
                <span class="how">Meet your deadlines with agile methodologies.</span>
                <span class="go">Develop &gt;</span>
                <a href="/services#development"></a>
            </div>

            <div class="service shadow">
                <i class="fa fa-area-chart"></i>
                <span class="what">Data Science</span>
                <span class="why">Gather and analyze</span>
                <span class="how">Change your perspective with valuable insights.</span>
                <span class="go">Analyze &gt;</span>
                <a href="/services#data-science"></a>
            </div>

            <div class="service shadow">
                <i class="fa fa-cloud"></i>
                <span class="what">Cloud Services</span>
                <span class="why">Build to scale</span>
                <span class="how">Integrate with providers to meet demands quickly.</span>
                <span class="go">Scale &gt;</span>
                <a href="/services#cloud-services"></a>
            </div>

            <div class="service shadow">
                <i class="fa fa-server"></i>
                <span class="what">Network Monitoring</span>
                <span class="why">Alert your team</span>
                <span class="how">Empower critical systems by reducing downtime.</span>
                <span class="go">Monitor &gt;</span>
                <a href="/services#network-monitoring"></a>
            </div>

            <div class="service shadow">
                <i class="fa fa-lock"></i>
                <span class="what">Security</span>
                <span class="why">Mitigate risk</span>
                <span class="how">Find your weak spots before someone else does.</span>
                <span class="go">Audit &gt;</span>
                <a href="/services#security"></a>
            </div>

            <div class="service shadow">
                <i class="fa fa-gears"></i>
                <span class="what">Managed Services</span>
                <span class="why">Maintain consistency</span>
                <span class="how">Focus on your enterprise goals and strategy.</span>
                <span class="go">Focus &gt;</span>
                <a href="/services#managed-services"></a>
            </div>

            <div class="service shadow">
                <i class="fa fa-wrench"></i>
                <span class="what">Automation</span>
                <span class="why">Continuously deliver</span>
                <span class="how">Enhance your CI/CD pipeline with adequate tooling.</span>
                <span class="go">Automate &gt;</span>
                <a href="/services#automation"></a>
            </div>

            <div class="service shadow">
                <i class="fa fa-users"></i>
                <span class="what">Training</span>
                <span class="why">Stay relevant</span>
                <span class="how">Technologies emerge often, changing our industry.</span>
                <span class="go">Disrupt &gt;</span>
                <a href="/services#training"></a>
            </div>

        </div>
    </section>

    <section class="our-company">
        <div class="container">

            <div class="bubble shadow">

                <div class="section-title">
                    <h3>Our Company</h3>
                    <span></span>
                </div>

                <h4>We solve problems.</h4>
                <p>Based in the Twin Cities, veteran-owned Heden Enterprises has experience solving complex enterprise problems and delivering quality solutions for over 15 years.</p>
                <h4>We transform business.</h4>
                <p>By analyzing your business needs while focusing on your goals and strategy, we achieve breakthrough results that improve your bottom line.</p>

                <a href="company" class="bfl">Learn more</a>
            </div>
        </div>
    </section>

    <section class="contact" id="contact">
        <div class="container">

            <div class="bubble shadow">

                <div class="section-title">
                    <h3>Free Estimate</h3>
                    <span></span>
                </div>

                <p id="thank-you">Thank you! Someone will reach out soon.</p>
                <p style="margin-bottom: 1em">Fill out the form below and someone from Heden Enterprises will contact you shortly.</p>

                <div class="estimate">
                    <label>
                        Name
                        <input id="name" type="text" />
                    </label>

                    <label>
                        Email
                        <input id="email" type="text" />
                    </label>

                    <label>
                        Project Details
                        <textarea id="project-details" cols="40" rows="5"></textarea>
                    </label>

                    <button id="contact-me">Contact me</button>
                </div>
            </div>
        </div>
    </section>
</main>


<?php

require("template/footer.php");
