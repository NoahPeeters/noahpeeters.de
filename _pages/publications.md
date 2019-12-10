---
title: "Publications"
excerpt: My publication
permalink: /publications/
header:
  teaser: /assets/images/my-awesome-post-teaser.jpg
---

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
