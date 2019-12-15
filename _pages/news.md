---
title: News
permalink: /news/
excerpt: External news article
---

Here I have linked all kinds of articles about me and my projects.

{% capture written_year %}'None'{% endcapture %}
{% for post in site.news reversed %}
  {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
  {% if year != written_year %}
    {% include archive-subtitle.html subtitle=year %}
    {% capture written_year %}{{ year }}{% endcapture %}
  {% endif %}
  {% include archive-single.html %}
{% endfor %}
