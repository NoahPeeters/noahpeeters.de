---
title: "Publications"
permalink: /publications/
---

Here you can find the papers I published during university.

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
