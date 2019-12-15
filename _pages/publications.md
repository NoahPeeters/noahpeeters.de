---
title: Publications
excerpt: My publication
permalink: /publications/
---

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
