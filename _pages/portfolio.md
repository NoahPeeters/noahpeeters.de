---
layout: archive
title: "Portfolio"
permalink: /portfolio/
author_profile: true
---

In my free time, I always have some side-projects. Here you can find a list of projects I published in recent years.

{% for post in site.portfolio %}
  {% include archive-single.html %}
{% endfor %}
