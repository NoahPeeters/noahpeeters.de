---
title: "Teaching"
permalink: /teaching/
---

Here you can find a collection of lectures I gave.

{% for post in site.teaching reversed %}
  {% include archive-single.html %}
{% endfor %}
